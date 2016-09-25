# eCommExamples.cURL
cURL transaction examples - Vantiv eComm using LitleXML

Payment transactions can be processed against Vantiv's internet accessible end-points for both on-line or batch transactions.

Developers can code applications that send, receive and parse appropriately formatted XML transactions themselves, or they can choose to use one of Vantiv's language specific SDKs to simplify coding.

For clarity in the examples below we use cURL - a tool well known to most developers.

Vantiv has multple endpoints depending on whether you are testing an application, certifying it or are in production. These first examples show how to test applications against the Vantiv eCommerce sandbox.

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








