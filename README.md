# eCommExamples.cURL

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
                <email>my-email-address@vantiv.com</email>
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

An authorization transaction will make sure that sufficient funds exist on a payment card and hold those funds by reducing the credit limit by an amount that corresponds to the authorization amount.

The authorization amount of $10.00 is shown in the <amount> element. You should not use a decimal character to delineate dollars and cents in the transaction. This example involves specifying real details about a payment card in the <card> element. 

While the approach will work, and is a good way to get started, a better practice is to use a solution like [Vantiv's eProtect](https://developer.vantiv.com/docs/DOC-1203) that subsitutes real credit card information for a low-value token at the point of capture. We will extend this simple example to use an eProtect token as an alternative to providing a credit card later on.

If running on a UNIX-like OS, remember to make the script executable.

````
$ chmod +x litle_auth.sh
````

Running the script should yield the following output:

````
$ ./litle_auth.sh
<litleOnlineResponse version='10.1' response='0' message='Valid Format' xmlns='http://www.litle.com/schema'>
  <authorizationResponse id='ididid' reportGroup='Money2020' customerId='12345'>
    <litleTxnId>773597363117474000</litleTxnId>
    <orderId>1</orderId>
    <response>000</response>
    <responseTime>2016-09-26T07:24:19</responseTime>
    <message>Approved</message>
    <authCode>43741</authCode>
  </authorizationResponse>
````

Note the LitleTxnId (Litle Transaction Id). When your application parses the retrieved XML, you will want to retain this value. The specifics of the response are encoded in the <authorizationResponse> element. 

##Capturing a transaction

Capturing a transaction will cause Vantiv to initiate a transfer of the previously authorized amount from the cardholder's issuing bank to the merchant's bank account. Note that the capture transaction needs to reference the transaction ID contained in the authorization response.

####Capturing a transaction (capture.sh)

````
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
````

When run the capture.sh script, you should see a response like the one below.

````
$ ./capture.sh
<litleOnlineResponse version='10.1' response='0' message='Valid Format' xmlns='http://www.litle.com/schema'>
  <captureResponse id='ididid' reportGroup='Money2020' customerId='12345'>
    <litleTxnId>967858740538999001</litleTxnId>
    <response>001</response>
    <responseTime>2016-09-26T07:44:14</responseTime>
    <message>Transaction Received</message>
  </captureResponse>
</litleOnlineResponse>
````

##Learning more

A complete set of [eCommerce documentation](https://developer.vantiv.com/community/ecommerce/pages/documentation) is available at the [Vantiv O.N.E. developer site](https://developer.vantiv.com/community/ecommerce/pages/documentation).







