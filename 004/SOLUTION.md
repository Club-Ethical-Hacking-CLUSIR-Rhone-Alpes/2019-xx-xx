# CLUSIR Rhône-Alpes

## Ethical Hacking Club - 2019 . 05 . 09

### Correction

#### Step 1

Analyze first communication

```http
PUT /piersy/GAWS27BPLR6C2LJQ HTTP/1.1
Host: cc.obrazek.ru

HTTP/1.1 201 Created
Location: http://cc.obrazek.ru/kamanda
Content-Type: application/json

{
    "krynica": "2.60.129.5",
    "identyfikatar": "GAWS27BPLR6C2LJQ"
}
```

Here we can understand that the client put a key **"GAWS27BPLR6C2LJQ** that will be associated with its IP address and will be used as an identifier.

#### Step 2

```http
GET /kamanda HTTP/1.1
Host: cc.obrazek.ru
X-data: eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJmbGFnIjoiJHtFSENfTVlOQU1FSVNKV1R9IiwiY21kIjoiTUhnMk56QjROalV3ZURjMElEQjROelF3ZURZeE1IZzNNakI0Tmpjd2VEWTFNSGczTkRCNE5XWXdlRGN3TUhnMlpqQjROek13ZURZNU1IZzNOREI0Tmprd2VEWm1NSGcyWlE9PSJ9.TMrz9rAsGsJDQ2xwpvukOSt18J8Qaq-R6zEiep4r1ubiX741wEb0YB3OG9GcqNqS96uQeeIbdq6KX6YK8Ajazw

HTTP/1.1 401 Unauthorized
Content-Type: text/plain

Стаяць!
```

This requests was rejected by the server, a non-authorized response was sent. In the response body we can read (after translation) : Stop!

What interests us is the new **X-data** header.
The format of this data is similar to a Json Web Token (**JWT**).

If we use the recipe "JWT Decode" in CyberChef we get:

```json
{
    "flag": "${EHC_MYNAMEISJWT}",
    "cmd": "MHg2NzB4NjUweDc0IDB4NzQweDYxMHg3MjB4NjcweDY1MHg3NDB4NWYweDcwMHg2ZjB4NzMweDY5MHg3NDB4NjkweDZmMHg2ZQ=="
}
```
We get the first flag : **${EHC_MYNAMEISJWT}**

The cmd content is base64 encoded, after decoding it look like that:

`0x670x650x74 0x740x610x720x670x650x740x5f0x700x6f0x730x690x740x690x6f0x6e`

After converting this hexadecimal content to ascii we obtain:

`get target_position`

So, the client ask to execute a command to the server in order to get the target position. But it seems that the client is unauthorized to do it.

#### Step 3

```http
GET /kamanda HTTP/1.1
Host: cc.obrazek.ru
X-data: eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjbWQiOiJNSGcyTnpCNE5qVXdlRGMwSURCNE56TXdlRFkxTUhnMk16QjROekl3ZURZMU1IZzNOREI0TldZd2VEWmlNSGcyTlRCNE56az0ifQ.LsBLbR17z4XpxcccFanP1VW8mcW_lvdBo3FOcozKmCNY0msvlSwzY1-KWuRvNklcF84D-ChJ2_zHU5m_XnYMfQ
```

The client resend a request to the *kamanda* resource, but with a different X-data header.

JWT decode: 

```json
{
    "cmd": "MHg2NzB4NjUweDc0IDB4NzMweDY1MHg2MzB4NzIweDY1MHg3NDB4NWYweDZiMHg2NTB4Nzk="
}
```

base64 decode:

`0x670x650x74 0x730x650x630x720x650x740x5f0x6b0x650x79`

hex convert:

`get secret_key`


The response attached to this request indicate that everything look good and that we can continue our work to the next resource:

`/dadzienyja/0`

The client request this url and get this data:

`GAWS27BPLR6C2LJQewogICAgIjAiOiAiYWVzLTEyOC1jYmMiCn0gGAWS27BPLR6C2LJQ`

We identify at the begining and the end the identificator firstly created. After removing it we obtain:

`ewogICAgIjAiOiAiYWVzLTEyOC1jYmMiCn0g`

base64 decode:

```json
{
    "0": "aes-128-cbc"
} 
```

If we repeat this operation for the 4 next request/response we get:

```json
{
    "1": "54z$"
} 

{
    "2": "pe2z"
} 

{
    "3": "y%gh"
} 

{
    "4": "&^r*"
} 
```

So we know that the algorithm that will be used is aes128, the key must be 16 char lenght. We can deduce that the key is the concatenantion of response 1 to 4.

key: `54z$pe2zy%gh&^r*`

#### Step 4

```http
GET /kamanda HTTP/1.1
Host: cc.obrazek.ru
X-data: eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjbWQiOiJNSGcyTnpCNE5qVXdlRGMwSURCNE56UXdlRFl4TUhnM01qQjROamN3ZURZMU1IZzNOREI0TldZd2VEY3dNSGcyWmpCNE56TXdlRFk1TUhnM05EQjROamt3ZURabU1IZzJaUT09In0.dUkJf7vF_A94nU-uZmZB7dxRdNYvJ6PBwuCsM2qK1pAcR7oIBNGfI48keEVZcp04KR0xr0OnDJxu0nMeA8wuDw

HTTP/1.1 200 OK
Content-Type: text/plain
GAWS27BPLR6C2LJQ10A12293EB8CEBB0AACB8EC24ED674171F5AADDBBF8D12880CB167EE28AD142FBDE5BD3F2A2FEA7D1B70F9AB4404D6D8FCF4E337DEA4DC52150015BA091B3B6EC40ACDBA4A5AB289B5CADC42E90DC673GAWS27BPLR6C2LJQ
```

The client send the same request `get target_position`

But this time, the server respond with a text:

`GAWS27BPLR6C2LJQ10A12293EB8CEBB0AACB8EC24ED674171F5AADDBBF8D12880CB167EE28AD142FBDE5BD3F2A2FEA7D1B70F9AB4404D6D8FCF4E337DEA4DC52150015BA091B3B6EC40ACDBA4A5AB289B5CADC42E90DC673GAWS27BPLR6C2LJQ`

As before, we strip the identificator `GAWS27BPLR6C2LJQ` from the text and get:

`10A12293EB8CEBB0AACB8EC24ED674171F5AADDBBF8D12880CB167EE28AD142FBDE5BD3F2A2FEA7D1B70F9AB4404D6D8FCF4E337DEA4DC52150015BA091B3B6EC40ACDBA4A5AB289B5CADC42E90DC673`

By using the recipe AES Decrypt on CyberChef with this configuration:

```yaml
key: "54z$pe2zy%gh&^r*"
iv: null
mode: "cbc"
input: "hex"
output: "raw"
```

We are able to decrypt the content:

```json
{
    "stanovisca": "45.784478, 4.888113",
    "flag": "${EHC_THE_END_2019}"
}
```

We get the target position and the last flag: **${EHC_THE_END_2019}**.