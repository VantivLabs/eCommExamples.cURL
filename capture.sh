#!/bin/sh
curl https://www.testlitle.com/sandbox/communicator/online --tlsv1.2  \
   -H "Content-Type: text/xml; charset=UTF-8"  \
   -X POST  \
   -d  \
     '<?xml version="1.0"?>
      <litleOnlineRequest version="10.3" xmlns="http://www.litle.com/schema" merchantId="default">
        <authentication>
            <user>JoesStore</user>
            <password>JoeyIsTheBe$t</password>
        </authentication>
        <capture id="ididid" reportGroup="Money2020" customerId="12345">
            <litleTxnId>773597363117474000</litleTxnId>
        </capture>
      </litleOnlineRequest>'
