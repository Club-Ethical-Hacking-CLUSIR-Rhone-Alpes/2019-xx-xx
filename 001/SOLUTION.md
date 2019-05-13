# CLUSIR Rhônes-Alpes

## Challenge 001 - Forensic: network frame and system log analyses

> author: Rémi ALLAIN <rallain@cyberprotect.one>
> version: 1.0
> date: 2018-12-13

### Correction

#### 1: The host name of the infected computer.

Answer: `Danger-Win-PC`

To find this we will check the NetBIOS requests by filtering on the ip. Be careful,
GEEOGRAPHIC corresponds to the domain. To make a difference, you have to look at the flag.

### 2: The MAC address of the infected computer.

Answer: `00:11:2f:d1:6e:52`

We'll look for the Bootstrap Protocol (BOOTP) which is a boot network protocol
allowing a client machine to discover its own IP Address, the address of a host
server, and the name of a file to be loaded into memory for execution.
In wireshark you can use the "bootp" filter and display the information related to the machine
10.22.15.119.

### 3: The account used on the infected machine.

Answer: `carlos.danger`

We notice the presence of the Kerberos protocol, we can then search for the `CNameString` related to our target.

### 4: Domains and IP addresses of any traffic associated with the infection.

Answer:

- 46.29.160.132 (alerts.txt) => http
    - shumbildac.com
        - http://shumbildac.com/WES/fatog.php?l=ngul5.xap
- 192.162.244.171 (alerts.txt) => http
    - dhsiwyqdlskwsqo.com
        - http://dhsiwyqdlskwsqo.com/images/Owsg6NXtcG4F/aQTGTFRGYCk/mwdnm
TGg8q5u_2/B23I8WXH1qhcd_2BC7kNQ/SplwlVD2F3jUMRCB/dTSK84tk3PapDt7/wErikpmrkQw22Bhba/FTtz6Avew/ty3DREXbyq083JlIg3zM/TEYrA_2BNXj
AICO93pa/QGJ.avi
        - +2 others
- 95.181.198.198.115 (alerts.txt) => https
- 46.229.214.92 (alerts.txt) => https

In the alerts.txt file the first external IP linked is 46.29.160.132, applying the
filter, there are two different protocols: TCP and HTTP. By filtering on HTTP we obtain two results. By clicking on "Follow > TCP Stream" you get the http stream.

### 5: Une chronologie des événements qui ont mené à l'infection.

Answer: 

| datetime | info |
| -------- | ---- |
| 2018-11-07 20:47:12 | Download XAP from shumbildac.com | 
| 2018-11-07 20:48 | Execution of the binary on the workstation | 
| 2018-11-07 20:48:46 | C&C - Download QJG.avi via 192.162.244.171 (dhsiwyqdlskwsqo.com) | 
| 2018-11-07 20:48:51 | C&C -Download 8lw2Htym.avi via 192.162.244.171 (dhsiwyqdlskwsqo.com) | 
| 2018-11-07 20:49:57 | HTTPS communication to 95.181.198.115 | 
| 2018-11-07 21:03:22 | HTTPS communication to 46.229.214.92 | 

### 6: Des informations pertinentes sur le malware

Retrieve the exe: click on export object in the file menu then select the 439kb octet-stream from shumbildac.com

To search for information, it is useful to retrieve the MD5 and SHA256 from the file to run scans on VirusTotal, IBM X-Force, Cyberprotect ThreatScore and AlienVault.

Thanks to the Sandbox we get more information, by opening the tracer.4.pcap capture we find an http connection requesting an .avi file.

Answer:

By correlating all our information, we realize that it is Urnsnif malware. The IoCs
listed corresponding to those found.

### 7: Une solution de rémediation et une liste d'IoC

Answer:

- Safe mode switch with network support
- Install an anti-spyware program
- Malware removal 

OR

- System restoration
- Selecting a pre-infection backup

IoC (indicateurs de compromission):

| type | data |
| ---- | ---- |
|md5 | 0d7a18ff70d35c8ae1806363ccd862d9 |
|sha256 | 97f149f146b0ec63c32abff204ae27638f0310536172b0f718f1a91a5672fe71 |
|ip | 46.29.160.132 |
|ip | 192.162.244.171 |
|ip | 95.181.198.115 |
|ip | 46.229.214.92 |
|domain | shumbildac.com |
|domain | dhsiwyqdlskwsqo.com |
|url | http://shumbildac.com/WES/fatog.php?l=ngul5.xap |
|domain | cyanteread.com |