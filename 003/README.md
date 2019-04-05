# CLUSIR Rhônes-Alpes

## Challenge 003 - OBRAZEK

> author: Rémi ALLAIN <rallain@cyberprotect.one>
> version: 1.0
> date: 2019-04-11

### Requirements

- docker

- docker-compose

### Installation

```sh
git clone https://github.com/remiallain/clusir-rha-ehc-2019
cd clusir-rha-ehc-2019/003
docker-compose up --force-recreate --build -d
```

### Scenario

The __"obrazek"__ site offers to post images in public mode. However, we believe that one of their servers is being used in a peanut diversion network. Your mission if you accept it, find the 5 flags that will ensure the justice of these peanuts.

Open your browser at **http://172.31.254.100**

You will have to find 5 flags in the format **${CEH_flag}**
