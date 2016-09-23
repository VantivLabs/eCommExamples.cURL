#!/bin/sh
curl https://www.testlitle.com/sandbox/communicator/online --tlsv1.2  \
   -H "Content-Type: text/xml; charset=UTF-8"  \
   -X POST  \
   -d  \
     '<?xml version="1.0"?>
      <litleOnlineRequest version="8.10" xmlns="http://www.litle.com/schema" merchantId="default">
        <authentication>
            <user>MyStore</user>
            <password>VantivR0ck$</password>
        </authentication>
        <authorization id="ididid" reportGroup="Money2020" customerId="12345">
            <orderId>1</orderId>
            <amount>1000</amount>
            <orderSource>ecommerce</orderSource>
            <billToAddress>
                <name>Jane Doe</name>
                <addressLine1>20 Main Street</addressLine1>
                <city>San Jose</city>
                <state>CA</state>
                <zip>95032</zip>
                <country>USA</country>
                <email>jdoe@litle.com</email>
                <phone>978-551-0040</phone>
            </billToAddress>
            <card>
                <type>MC</type>
                <number>5454545454545454</number>
                <expDate>1112</expDate>
                <cardValidationNum>123</cardValidationNum>
            </card>
        </authorization>
      </litleOnlineRequest>'
