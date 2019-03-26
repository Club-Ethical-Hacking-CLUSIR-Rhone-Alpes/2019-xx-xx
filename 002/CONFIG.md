
# WEB

| user | pass |
|---|---|
| h.duval | ?? |
| s.peronni | ?? |
| j.otomal | ?? |

# MYSQL

| user | pass |
|---|---|
| root | rP4z8::Dkhx49vR9::7eaRTy8je9g258Pcep86a6w2xXf::98wuTraxQ::n38 |
| pvex_dbuser | 10UjtJWyoYORw |

```sql
CREATE TABLE `admin` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`name` varchar(200) NOT NULL,
`title` varchar(200) DEFAULT NULL,
`username` varchar(200) NOT NULL,
`passwd` varchar(512) NOT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `servers` (
`id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` varchar(200) NOT NULL,
`creds` varchar(500) NOT NULL,
`status` varchar(50) NULL DEFAULT 'down',
`int` varchar(80) NOT NULL,
`ext` varchar(80) NULL
);

CREATE TABLE `${EHC_BetweenUS}` (
`null1` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
`null2` int NULL
);

```

# SSH

| user | pass |
|---|---|
| root | rmEBx42homEBx42lTqohoh |
| pvexuser3ro | J3Sape1R00t |


