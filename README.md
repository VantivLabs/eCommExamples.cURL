# eCommExamples.cURL
cURL transaction examples - Vantiv eComm using LitleXML

Processing payment transactions involves sending and receiving XML formatted messages to and from Vantiv's internet accessible endpoints.

Developers can build appropriate messages themselves, or they can choose to use one of Vantiv's [language specific SDKs](https://developer.vantiv.com/community/ecommerce/pages/sdks).  The XML specification is available [here](https://developer.vantiv.com/docs/DOC-1172).

For clarity, some examples are providing using  cURL.

Vantiv has multple endpoints depending on whether you are testing an application, certifying it or are in production. These first examples show how to test applications against the Vantiv eCommerce sandbox. The sandbox is stateless and does not require any credentials to work. It is a good way to test simple transactions and make sure that your program is able to connect to the end point and send and receive appropriate formatted messages. Once you have basic functionality working you can request credentials and test against Vantiv's pre-live environment.

##Authorizing a transaction

A bash script that sends an Authorization transaction to the Vantiv eCommerce sandbox is shown below:

#### Contents of auth.sh

````
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
````








