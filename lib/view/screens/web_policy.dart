import 'package:brixmarket/utils/utils.dart';
import 'package:brixmarket/view/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../config/theme/color.dart';
import '../widgets/custom_text.dart';
import '../widgets/footer_page.dart';
import '../widgets/mobile_appbar.dart';

class PolicyWeb extends StatelessWidget {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  PolicyWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainPadding = Get.width < 480
        ? Get.width * 0.05
        : Get.width * 0.06 + Get.width * 0.009;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        key: homeScaffoldKey,
        backgroundColor: Pallet.primaryBackgroundLight,
        drawer: buildDrawer(context),
        appBar: appBarWeb(homeScaffoldKey),
        body: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: Pallet.primaryBackgroundLight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/hero1.jpg'))),
                      child: Container(
                        width: Get.width,
                        height: isMobile() ? 140 : 300,
                        color: Colors.black.withOpacity(0.7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'Privacy Policy',
                              size: isMobile() ? 32 : 48,
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 64),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: mainPadding),
                      child: Column(children: [
                        policyContent(),
                      ]),
                    ),
                    const SizedBox(height: 24),
                    pageFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

policyContent() {
  return const HtmlWidget(('''
  <style>
         table, th, td {
            border: 1px solid black;
         }
      </style>
                          <section class="about-area ptb-70">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-12">
                        <div class="about-content">
                           <p>&nbsp;</p>
                           <h2><strong>Effective Date: July 11, 2022</strong></h2>

<p>Brixmarket is operated by&nbsp;<a href="http://www.dilmaksolutions.com/">Shua Properties Limited</a>. This Privacy Policy applies to Information that are personal processed by Brixmarket in the course of doing business, including, Brixmarket.com, the Brixmarket Applications, as well as additional Site/App/applications operated by our affiliates and subsidiaries, including Shua Properties Limited and the services provided through the Site/App or Apps (collectively refer in as the "Marketplace").</p>
<p>&nbsp;</p>
<p>The terms "<strong>Brixmarket</strong>," "<strong>we</strong>," "<strong>us</strong>," and "<strong>our</strong>" includes Brixmarket affiliates and subsidiaries (including, without limitation, Shua Properties Limited as applicable in Nigeria). </p>




<p><strong>&nbsp;</strong></p>
<p><strong>This Privacy Policy contains the following sections:</strong></p>
<ol>
<li>Collection and Use of Personal Information.</li>
<li>Sharing of Personal Information.</li>
<li>Choices you make.</li>
<li>Rights of Individual in Personal Information.</li>
<li>Retention of Personal Information.</li>
<li>Storage and Security of Personal Information.</li>
<li>Other Germaine Information</li>
</ol>
<p>&nbsp;</p>
<h2><strong>1. Collection and Use of Personal Information</strong></h2>
<p>This Privacy Policy covers our use of Personal Information. "<strong>Personal Information</strong>," connotes any information that relates to an individual and can -- either on its own or in combination with other information -- identify you as a person. Personal information does not include information that has been de-identified or aggregated such that you can no longer be identified.</p>
<p>The types of information we collect depends on your level of engagement with the Marketplace. The more you interact with the Marketplace, the more information we need to provide the Marketplace. This Section explains how we collect and use personal information based on your level of engagement with the Marketplace.</p>

<p><strong>A. All Users of the Brixmarket Site/App </strong></p>
<p>From registered and unregistered users of the Site/App, we automatically receive and record information whenever you interact with the Site/App. This includes IP address data from our server logs, cookie information, browser information, information about your activity while on the Site/App (such as the pages you request, properties that you view or save, and property that you claim), and the URL of the site you came to the Site/App from. We also may collect the mobile device ID (such as the ID for Advertising on iOS and Android ID on Android) from users of the Brixmarket Applications. If permitted by the settings on your device and/or with your consent, we will also collect your geo-location information. We use this to provide you with location specific information, such as property/homes for sale near your current location as determined by your geolocation, and information about listing your property/home for sale based on your geolocation. We may also approximate your location based off your IP address, to customize your experience on our Site/App.</p>
<p>We may also use the information listed above to help diagnose problems and performance with the Marketplace, analyze trends, customize your experience, and administer the Marketplace. We may provide IP addresses to third-parties to help us analyze website user survey data. We may also use the information described in this section to better target information about Brixmarket's Site/App and Marketplace, for example, by displaying more accurate or relevant information on our Site/App, matching you to a public record listing of a property, customizing the advertising we display on third party websites and platforms, and sending better targeted and customized messages, including via email and/or push notifications.</p>



<p><strong>B. Registered Users of the Brixmarket Site/App </strong></p>
<p>We are required to collect certain information, including your name and email address, as a condition of our licenses with the multiple real estate listing Marketplace in order to allow you to access the full listings. You give us this information when you create your Brixmarket account. When you give us this information at one of our events, or upon your request, we will create a Brixmarket account for you, and you agree that this Privacy Policy and our <a href="https://www.redfin.com/about/terms-of-use">Terms of Use apply</a>. In addition, when you are signed in to your Brixmarket account and using Brixmarket through Instagram, Facebook, Twitter, or any other third-party authorization service, we may make use of the information that they provide us to further customize your Brixmarket experience. We may share Personal Information with such third parties to deliver Brixmarket tailored content both on our Marketplace and on third party Sites (e.g., social media sites)..</p>
<p><strong>   Brixmarket:</strong> Brixmarket has a feature that allows you to upload notes and photos about a property, save searches, add favorites and x-outs, and otherwise organize property/homes that may interest you. We save all of this "Brixmarket" information for use later in connection with our Marketplace. It is stored with your Brixmarket account information.</p>
<p><strong>   Account Password Security:</strong> Your Brixmarket account password is encrypted on our server. It is your responsibility not to disclose your password to other people and to ensure you maintain its security.</p>
<p><strong>   Account Updates:</strong> By visiting your Brixmarket: <a href="https://www.redfin.com/myredfin/settings">Account Settings</a>, you can correct, amend, add or delete Personal Information associated with your account. However, even after you update information, we may maintain a copy of the original information in our records as required by applicable law or other legal obligation. .</p>


<p><strong>C. Property Tours, Real Estate Classes, and other In-Person Meetings </strong></p>
<p>When you submit a property/home tour request, we will ask for your availability, date and time preferences for checking the property for verification, as well as your phone number We may ask for similar information when you request or attend a property/home buying or selling class, or when you request or attend a strategy session or similar in-person meeting with a Brixmarket agent. We may also ask some questions so that our agent can verify your identity, and such information will be used to register you for a Brixmarket account. When you meet up with one of our agents, the agent may ask you to verify your identity and may even ask to see a photo ID.</p>

<p><strong>D. Brixmarket Clients </strong></p>
<p>When you are getting ready to buy or sell a property and you start working with our coordinators and agents, you become a Brixmarket client. As part of the property/home purchase or sale process, you will need to provide a lot of information as is customary for a property/home purchase or sale transaction. This information can include, without limitation, your name, address, phone number, email address, financial or payment information, including without limitation, buyer loan pre-approval documentation and seller property information. We ask you, as a buyer, for your budget range to determine which property/homes/properties are in your price range and to help you make an offer more quickly when you do find a property/home/property. You, as a seller, may be legally required to disclose certain information about your property to prospective buyers. Once you sign a listing agreement or buyer agreement with us, your relationship with Brixmarket is governed by that agreement, as well as our online <a href="https://www.redfin.com/about/terms-of-use">Terms of Use</a> and this Privacy Policy.</p>


<p><strong>E. Communications with Brixmarket</strong></p>
<p>Brixmarket may collect Personal Information from you such as email address, phone number, or mailing address when you request information about our Marketplace, register for our newsletter, request customer or technical support, or otherwise communicate with us.</p>

<p><strong>F. Marketing</strong></p>
<p>We may send marketing materials to Brixmarket account holders and clients using various communication channels, including without limitation, email, text messages/SMS, push notifications, telephone calls, and direct mail. Individuals may also subscribe to Listing Alert Emails or other notifications with information such as customized summaries of property/homes for sale. Brixmarket may send you Brixmarket-related news and surveys in accordance with applicable law.</p>

<p><strong>G. Surveys</strong></p>
<p>Brixmarket may contact you to participate in surveys. If you decide to participate, you may be asked to provide certain information, which may include Personal Information.</p>

<p><strong>H. Sharing with Friends or Colleagues </strong></p>
<p>Brixmarket's Marketplace may allow you to forward or share certain content with a friend or colleague, such as an email inviting your friend to use our Marketplace. Email addresses that you may provide for a friend or colleague will be used to send your friend or colleague the content or link you request in accordance with applicable law.</p>

<p><strong>I. Interactive Features </strong></p>
<p>Brixmarket may offer interactive features such as chat Marketplace, forums, and social media pages. We may collect the information you submit or make available through these features. Any content you provide on the public sections of these channels will be considered "public" and will not be subject to the privacy protections referenced herein.</p>

<p><strong>J. De-Identified and Aggregated Information </strong></p>
<p>We may use Personal Information and other information about you to create de-identified and/or aggregated information, such as de-identified demographic information, de-identified location information, de-identified or aggregated trends, reports, or statistics, information about the computer or device from which you access our Marketplace, or other analyses we create. De-identified and aggregated information is used for a variety of functions, including the measurement of visitors' interest in and use of various portions or features of the Site/App and Marketplace. De-identified and aggregated information is not Personal Information, and we may use and disclose such information in a number of ways, including research, internal analysis, analytics, and any other legally permissible purpose.</p>

<p><strong>K. Information We Collect Automatically </strong></p>
<p>We may collect certain information automatically when you use the Marketplace. This information may include your Internet protocol (IP) address, user settings, IMEI, MAC address, cookie identifiers, mobile carrier, mobile advertising and other unique identifiers, details about your browser, operating system or device, location information, Internet service provider, pages that you visit before, during and after using the Marketplace, information about the links you click, and other information about how you use the Marketplace. Information we collect may be associated with accounts and other devices.</p>
<p><strong>L. Cookies and Pixel Tags/Web Beacons </strong></p>
<p>We, as well as third parties that provide content, advertising, or other functionality on the Marketplace, may use cookies, pixel tags, local storage, and other technologies ("Technologies") to automatically collect information through the Marketplace. Technologies are essentially small data files placed on your computer, tablet, mobile phone, or other devices that allow us to record certain pieces of information whenever you visit or interact with our Site/App and Marketplace.</p>
<p><strong>   Cookies.</strong> Cookies are small text files placed in visitors' device browsers to store their preferences. Most browsers allow you to block and delete cookies. However, if you do that, the Marketplace may not work properly.</p>
<p><strong>    Pixel Tags/Web Beacons.</strong> A pixel tag (also known as a web beacon) is a piece of code embedded on the Site/App that collects information about users' engagement on that web page. The use of a pixel allows us to record, for example, that a user has visited a particular web page or clicked on a particular advertisement.</p>
<p>You may stop or restrict the placement of Technologies on your device or remove them by adjusting your preferences as your browser or device permits.</p>

<p><strong>M. Information from Other Sources </strong></p>
<p>We may obtain information about you from other sources, including through third-party Marketplace and organizations to supplement information provided by you. This supplemental information allows us to verify information that you have provided to us and to enhance our ability to provide you with the Marketplace.</p>


<p><strong>N. Other Uses of Information</strong></p>
<p>In addition to the specific collection and uses listed above, we may use any of the Personal Information we collect for the following business purposes:</p>
<ol>
<li> to operate our Site/App and provide our Marketplace in accordance with our <a href="https://www.redfin.com/about/terms-of-use">Terms of Use</a> and/or any other agreement you may have with us;</li>
<li> to manage your Personal Information and accounts;</li>
<li> to respond to your questions or inquiries; </li>
<li> to conduct promotional activities, including contests or surveys;</li>
<li> to undertake internal research for technological development and demonstration;</li>
<li> to improve, upgrade or enhance our Site/App and Marketplace;</li>
<li> to send you informational or promotional communications;</li>
<li> to detect bugs, security incidents (including to protect against malicious, deceptive, fraudulent, or illegal activity, and prosecute those responsible for that activity);</li>
<li> to identify and repair errors that impair existing intended functionality;</li>
<li> to undertake activities to verify or maintain the quality or safety of a Service, Site or transaction;</li>
<li> to carry out other purposes that are disclosed to you and/or to which you consent; and</li>
<li> to pursue our legitimate interests where your rights and freedoms do not outweigh these interests.</li>
</ol>

<h2><strong>2. Sharing of Personal Information </strong></h2>
<p>While we do not exchange your Personal Information with others for monetary or other valuable consideration, we may share your Personal Information with the following categories of third parties as part of our Marketplace to you or to assist us in conducting our marketing and advertising, or for other business or commercial purposes listed above in this Privacy Policy.</p>

<p><strong>A. Public Record Information </strong></p>
<p>Please be aware that property/home sales and purchases may be a matter of public record, and your name and address, the price you paid, your property taxes, and other information may be available from public Site/App regardless of the brokerage(s), if any, who assist in the transaction. We post on our Site/App some information that typically becomes part of the public record of a property/home sale or purchase.</p>

<p><strong>B. Non-Public Record Information </strong></p>
<p>We share information obtained from you, Realtors and other third-party sources that is not on the public record to facilitate your property/home purchase or sale transaction. This includes:</p>


<ol>
<li><strong> Service Providers to all Brixmarket Clients</strong>: Our agents work with third parties to process your property/home search and sale transaction and must share your information with those third parties. Examples include MLSs and providers of software used for document preparation and electronic signing</li>
<li><strong> Partner Agents</strong>: A Partner Agent is employed by or works with another brokerage and is not a representative or employee of Brixmarket. Partner Agents have contracted with us to provide Brixmarket-quality service to a wider range of customers. We'll refer you to a Partner Agent in our discretion. If you are referred to a Partner Agent for your property/home purchase or sale transaction, we share your information with that Partner Agent so they can assist you. Brixmarket is not responsible for the work performed or the Marketplace provided by Partner Agents in any manner.</li>
<li><strong> Property/home Seller Service Providers</strong>: As is customary as your property/home sales agent, we share your listing information with Realtors and other listing websites. As a result, your listing may appear on more than one website. We may also share your listing and contact information with listing vendors such as photographers, property/home staging experts and property/home repair professionals like plumbers and electricians, as needed.</li>
<li><strong> Property/home Buyer Service Providers</strong>: As is customary as your property/home purchase agent, we must share your buying information with inspectors, title companies, escrow agents, closing attorneys, lenders, and other third parties as needed to process your transaction.</li>
<li><strong> Potential Buyers</strong>: By law, we are required to disclose certain information about your property to potential buyers.</li>
</ol>

<p><strong>C. Negotiations</strong></p>
<p>We also post price offers and counteroffers on our Site/App. We do not post your name on our Site/App without your permission, but if the sale is closed, the price and the fact that you bought or sold your house at that price may be a matter of public record.</p>
<p><strong>D. Brixmarket Corporate Family </strong></p>
<p>We may share your information with members of the Brixmarket family of entities for various purposes, including to: (i) provide the Marketplace to you; (ii) help detect and prevent potentially illegal and fraudulent acts and other violations of our policies and agreements; (iii) help with marketing initiatives; and (iii) manage and improve Brixmarket products, Site/App, Marketplace and tools.</p>
<p><strong>E. Brixmarket Requests </strong></p>
<p>Through the Marketplace, you can make a request to tour a property/home, get in contact with a real estate agent, receive help leasing, selling or buying a property/home, or submit other requests. When you make such a request through Brixmarket, you authorize Brixmarket to share your Personal Information including your contact information, property/home search history, favorites and saved searches, with a real estate professional (a Brixmarket Agent or staff member, or a Partner Agent) for the purpose of responding to your request.</p>
<p><strong>F. Service Providers</strong></p>
<p>We may share your Personal Information with third-party service providers that assist us in providing the Marketplace. We use reasonable efforts do so with the appropriate contractual protection in place to ensure that your Personal Information is protected and used only in accordance with this Privacy Policy.</p>
<p><strong>G. Business Partners </strong></p>
<p>We may provide Personal Information to business partners to provide you with a product or service you have requested. We may also provide Personal Information to business partners with whom we jointly offer products or Marketplace in accordance with applicable law.</p>
<p><strong>H. Third-Party Cookies and Information Used to Target Ads to You </strong></p>
<p>We may share the information that we collect about you with others (including advertising networks and service providers) to tailor and serve you ads on our Marketplace, as well as other website and social media networks. This practice is commonly referred to as "interest-based advertising" or "online behavioral advertising." These advertising networks track your online activities over time by collecting information through automated means, including through the use of Technologies (e.g., cookies, web-beacons and other methods). This allows Brixmarket to target our advertising to you through demographic, behavioral and contextual means. As a result, you may see ads for Brixmarket on other website and social media.</p>
<p><strong>I. APIs and SDKs </strong></p>
<p>We may use third party APIs and software development kits ("SDKs") as part of the functionality of our Marketplace. APIs and SDKs may allow third parties, including advertising partners, to collect your Personal Information to provide our service related content that is more relevant to you. For more information about our use of APIs and SDKs, please contact us as set forth below.</p>
<p><strong>J. Information Disclosed in Connection with Business Transactions </strong></p>
<p>If we are involved in a merger, acquisition, financing due diligence, reorganization, bankruptcy, receivership, purchase or sale of assets, or transition of service to another provider, then your information may be sold or transferred as part of such a transaction as permitted by law and/or contract.</p>
<p><strong>K. Information Disclosed for Our Protection and the Protection of Others </strong></p>
<p>We cooperate with government and law enforcement officials or private parties to enforce and comply with the law. We may disclose any information about you to government or law enforcement officials or private parties as we, in our sole discretion, believe necessary or appropriate: (i) to respond to claims or legal processes (including court order); (ii) to protect our property, rights and safety and the property, rights and safety of a third party or the public in general; and (iii) to stop any activity that we consider illegal, unethical or legally actionable.</p>
<p><strong>L. Other Purposes </strong></p>
<p>Brixmarket may share your Personal Information for other purposes that are clearly disclosed to you at the time you provide Personal Information or with your consent.</p>

<h2><strong>3. Choices You make </strong></h2>
<p><strong>A. General </strong></p>
<p>You may have the right to opt in, object to or opt out of certain uses of your Personal Information. Where you have consented to the processing of your Personal Information, you may withdraw that consent at any time by contacting us as described below. Even if you opt out, we may still collect and use Personal Information regarding your activities on our Site/App, Marketplace and/or information from the advertisements on third party website for other legal purposes as described above in accordance with applicable law.</p>

<p><strong>B. Electronic Messages, Phone Calls and other Communications </strong></p>
<p>If you receive an unwanted email from Brixmarket, you can visit the Email Preferences section of your <a href=https://www.redfin.com/myredfin/alerts-settings>Brixmarket: Alerts & Emails</a> or use the unsubscribe link found at the bottom of the email to opt out of receiving future emails. Note that you will continue to receive transaction-related emails regarding products or Marketplace you have requested. We may also send you certain non-promotional communications regarding us and our Marketplace, and you will not be able to opt out of those communications (e.g., communications regarding the Marketplace or updates to our Terms of Use or this Privacy Policy).</p>
<p><strong>C. Opting-Out of Technologies and Tracking </strong></p>
<ol>
<li><strong> Brixmarket Cookies </strong>: We put Brixmarket cookies on your device's browser to help us keep track of when you were last on the Site/App, and what you last searched on the Site/App. While you are free to disable cookies on your browser, we recommend that you leave cookies activated to use some of the most useful Brixmarket features.</li>
<li><strong> Third-Party Cookies for Analytics</strong>: We may use third parties, such as comScore and Google, to help us analyze how people are using the Marketplace, and those third parties are authorized to use Technologies to access Personal Information regarding visitors to the Site/App.</li>
<li><strong> Google Analytics</strong>: We use the Google Analytics service to provide us with demographic data about our users on a de-identified basis. This Google service uses a cookie that can be recognized by Google or its affiliate DoubleClick when you visit other website. For more information about Google Analytics, please visit <a href=www.google.com/policies/privacy/partners/>www.google.com/policies/privacy/partners/</a>. You can opt out of Google Analytics' collection and use of data generated by your use of the Marketplace by going to <a href=http://tools.google.com/dlpage/gaoptout>http://tools.google.com/dlpage/gaoptout</a>.</li>
<li><strong> Opting Out of Brixmarket's Interest-Based Advertising</strong>: If you do not want Brixmarket to collect, use and share information about you to deliver interest-based advertising, please follow the opt-out instructions. Please note that most opt-out mechanisms are cookie-based and will only affect the specific computer and browser that is used to submit an opt-out request. If you have multiple computers or change computers, or use multiple browsers, you will need to submit opt-out requests for each such computer or browser. In addition, if you delete, block or otherwise restrict cookies, you will need to renew the opt-out choices to ensure that any opt-out cookies remain effective.</li>
<li><strong> Opting Out of Interest-Based Advertising Generally</strong>: The online advertising industry also provides website from which you may opt out of receiving targeted ads from data partners and other advertising partners that participate in self-regulatory programs.</li>
<li><strong> Opting Out of Mobile Device ID Tracking</strong>: Mobile device users may opt-out of receiving some interest-based advertising in their mobile apps by following the instructions for <a href=https://support.google.com/googleplay/android-developer/answer/6048248?hl=en>Android</a> and <a href=https://support.apple.com/en-us/HT202074>Ios</a>. Please note that precise instructions may vary by device.</li>
<li><strong> Do Not Track</strong>: Do Not Track <strong>("DNT")</strong> is a privacy preference that users can set in certain web browsers. Please note that we do not respond to or honor DNT signals or similar mechanisms transmitted by web browsers.  Flash Cookies: Brixmarket does not currently use flash cookies, but we may in the future. Please note that flash cookies do not reside in your browser, so your browser settings will not affect them.</li>
<li><strong> Flash Cookies</strong>: Brixmarket does not currently use flash cookies, but we may in the future. Please note that flash cookies do not reside in your browser, so your browser settings will not affect them.</li>
</ol>

<p><strong>D. Mobile Devices</strong></p>
<p>We may send you push notifications through the Brixmarket mobile application. You may at any time opt-out from receiving these types of communications by changing the settings on your mobile device. Brixmarket may also collect location-based information if you use our mobile applications. You may opt-in or opt-out of this collection by changing the settings on your mobile device.</p>

<p><strong>E. Delete your Account</strong></p>
<p>You may delete your Brixmarket account on your <a href="https://www.redfin.com/myredfin/settings">Brixmarket: Account Settings</a> page under "Delete Account" section. We retain Personal Information for as long as we have a valid business purpose to or to meet our legal obligations. Brixmarket may be required to keep a copy of your Personal Information in accordance with Section 5 below.</p>

<h2><strong>4. Rights of Individual in Personal Information </strong></h2>
<p>In accordance with applicable law, you may have the right to:</p>
<ol>
<li>request confirmation of whether we are processing your Personal Information;</li>
<li>obtain access to or a copy of your Personal Information; </li>
<li>receive an electronic copy of Personal Information that you have provided to us, or ask us to send that information to another company (the "right of data portability");</li>
<li>restrict our uses of your Personal Information;</li>
<li>seek correction or amendment of inaccurate, untrue, incomplete, or improperly processed Personal Information;</li>
<li>request erasure of Personal Information held about you by Brixmarket, subject to certain exceptions prescribed by law. If you would like to exercise any of these rights, please contact us as set forth below.</li>
</ol>

<p>We will process such requests in accordance with applicable laws. To protect your privacy, Brixmarket may take steps to verify your identity before fulfilling your request. </p>
<p>We may collect and report annual metrics for statistical purposes only.</p>

<h2><strong>5. Retention of Personal Information  </strong></h2>
<p>Brixmarket retains the information we receive as described in this Privacy Policy for as long as you use our Marketplace or as necessary to fulfill the purpose(s) for which it was collected, provide our Marketplace, resolve disputes, establish legal defenses, conduct audits, pursue legitimate business purposes, enforce our agreements, and comply with applicable laws.</p>

<h2><strong>6. Storage and Security of Personal Information </strong></h2>
<p>Brixmarket is headquartered in the Nigeria. You agree that we may store and process the information we collect anywhere in the world, including but not limited to, the Nigeria, the US, the EU, or other countries.</p>
<p>We take steps to ensure that your information is treated securely and in accordance with this Privacy Policy. Unfortunately, the Internet cannot be guaranteed to be 100% secure, and we cannot ensure or warrant the security of any information you provide to us. To the fullest extent permitted by applicable law, we do not accept liability for unintentional disclosure.</p>
<p>By using the Marketplace or providing Personal Information to us, you agree that we may communicate with you electronically regarding security, privacy, and administrative issues relating to your use of the Marketplace. If we learn of a security system's breach, we may attempt to notify you electronically by posting a notice on the Marketplace, by mail or by sending an e-mail to you.</p>

<h2><strong>7. Other Germaine Information </strong></h2>
<p><strong>A. Local Privacy Policy Provisions </strong></p>
<p>The follow provisions supplement the information contained in our Privacy Policy above and applies solely to individuals, who reside in the territory of Nigeria ("consumer" or "you") in our role as a business. We adopt this notice to comply with the Local Law and or any terms defined in Law have the same meaning when used in this notice</p>

<p><strong>Information We Collect </strong></p>
<p>In providing our Marketplace, we may collect information that identifies, relates to, describes, is reasonably capable of being associated with, or could reasonably be linked, directly or indirectly, with a particular consumer or household ("Personal Information").</p>
<p>Personal Information does not include:</p>
<ol>
<li> Publicly available information from government records.</li>
<li> Deidentified or aggregated consumer information.</li>
<li> Information excluded from the scope of Law.</li>
</ol>
<p>     We may collect the following categories of Personal Information from our consumers in our role as a business for as long as twelve (12) months (indicated with a Yes below):</p>
<table>
  <tr>
    <th><h3><strong>Category</strong></h3></th>
    <td><h3><strong>Examples</strong></h3></td> 
    <td><h3><strong>Collected</strong></h3></td>
  </tr>
  <tr>
    <th><strong>Identifiers</strong></th>
    <td><strong>Name, alias, postal address, unique personal identifier, online identifier, Internet Protocol address, email address, account name, Social Security, or other similar identifiers.</strong></td> 
    <td><strong>Yes</strong></td>
  </tr>
  <tr>
    <th><strong>Protected classification characteristics under Local or federal law</strong></th>
    <td><strong>Age, race, color, ancestry, national origin, citizenship, religion or creed, marital status, medical condition, physical or mental disability, sex (including gender, gender identity, gender expression, pregnancy or childbirth and related medical conditions), sexual orientation, veteran or military status, genetic information (including familial genetic information).</strong></td> 
    <td><strong>No</strong></td>
  </tr>
  
  <tr>
    <th><strong>Commercial information. </strong></th>
    <td><strong>Records of personal property, products or Marketplace purchased, obtained, or considered, or other purchasing or consuming histories or tendencies.</strong></td> 
    <td><strong>Yes</strong></td>
  </tr>
  
  <tr>
    <th><strong>Biometric information. </strong></th>
    <td><strong>Physiological, biological, or behavioral, characteristics (including DNA) that can be used to establish individual identity, or imagery of the iris, retina, fingerprint, face, hand, palm, vein patterns, and voice recordings, from which an identifier template such as a faceprint, a minutiae template, or a voiceprint, can be extracted and keystroke patterns or rhythms, gait patterns, or rhythms, and sleep, health or exercise data that contain identifying information.</strong></td> 
    <td><strong>No</strong></td>
  </tr>
  
  <tr>
    <th><strong>Internet or other electronic network activity.</strong></th>
    <td><strong>Browsing history, search history, information on a consumer's interaction with an internet website, application, or advertisement.</strong></td> 
    <td><strong>Yes</strong></td>
  </tr>
  
  <tr>
    <th><strong>Geolocation data. </strong></th>
    <td><strong>Physical location or movements. </strong></td> 
    <td><strong>Yes</strong></td>
  </tr>
  
  <tr>
    <th><strong>Sensory data.</strong></th>
    <td><strong>Audio, electronic, visual, thermal, olfactory, or similar information. </strong></td> 
    <td><strong>No</strong></td>
  </tr>
  
  <tr>
    <th><strong>Professional or employment-related information.</strong></th>
    <td><strong>Current or past job history or performance evaluations.</strong></td> 
    <td><strong>No</strong></td>
  </tr>
  
  <tr>
    <th><strong>Non-public education Information</strong></th>
    <td><strong>Education records directly related to a student maintained by an educational institution or party acting on its behalf, such as grades, transcripts, class lists, student schedules, student identification codes, student financial information, or student disciplinary records.</strong></td> 
    <td><strong>No</strong></td>
  </tr>
  
  <tr>
    <th><strong>Inferences drawn from other personal information to create a profile about a consumer</strong></th>
    <td><strong>Profile reflecting a consumer's preferences, characteristics, psychological trends, predispositions, behavior, attitudes, intelligence, abilities, and aptitudes.</strong></td> 
    <td><strong>No</strong></td>
  </tr>
  <tr>
    <th><strong>Other Personal information categories listed in the categories above</strong></th>
    <td><strong>A name, signature, National Identity Number, physical characteristics or description, address, telephone number, passport number, driver's license or state identification card number, insurance policy number, education, employment, employment history, bank account number, credit card number, debit card number, or any other financial information, medical information, or health insurance information. Personal Information does not include publicly available information that is lawfully made available to the general public from federal, state, or local government records. Note: Some personal information included in this category may overlap with other categories.</strong></td> 
    <td><strong>No</strong></td>
  </tr>
  =
</table>
<p><strong>Categories of Sources from Which Personal Information is Collected</strong></p>
<p>We obtain the categories of Personal Information listed above from the types and categories of sources described above in this Privacy Policy</p>
<p><strong>Business or Commercial Purposes for Collecting Personal Information </strong></p>
<p>We may use, or disclose the Personal Information we collect for the business purposes describe above in this Privacy Policy. We will not collect additional categories of Personal Information or use the Personal Information we collected for materially different, unrelated, or incompatible purposes without providing you additional notice.</p>
<p><strong>Disclosures of Personal Information for a Business Purpose</strong></p>
<p>We may disclose your Personal Information to the third parties or others as described above in this Privacy Policy, for any of the business purposes described above in this Privacy Policy. When we disclose Personal Information for a business purpose, we enter a contract that describes the purpose and requires the recipient to both keep that Personal Information confidential and not use it for any purpose except performing the contract.</p>
<p>Within a period twelve (12) months, we would not disclosed the following categories of Personal Information in our role as a business for a business purpose:</p>
<ol>
<li>Identifiers</li>
<li>Commercial information </li>
<li>Internet information </li>
</ol>

<p><strong>Sales of Personal Information </strong></p>
<p>Within a period twelve (12) months, we would not sell any Personal Information in our role as a business except as defined in Law or other applicable laws.</p>
<p><strong>Your Rights and Choices </strong></p>
<p>Law provides consumers (Local residents) with specific rights regarding their Personal Information. This section describes your Legal rights and explains how to exercise those rights.</p>
<p><strong>Right to Know</strong></p>
<p>You have the right to request that we disclose certain information to you about our collection and use of your Personal Information over the past 12 months. Once we receive and confirm your request, we will disclose to you:</p>
<ol>
<li> The specific pieces of Personal Information we collected about you</li>
<li> The categories of Personal Information we collected about you. </li>
<li> The categories of sources from which the Personal Information is collected about you. </li>
<li> Our business or commercial purpose for collecting or selling that Personal Information. </li>
<li> The categories of third parties with whom we share that Personal Information. </li>
<li> If we sold or disclosed your Personal Information for a business purpose </li>

</ol>
<p><strong>Right to delete</strong></p>
<p>You have the right to request that we delete any of your Personal Information that we collected from you and retained, subject to certain exceptions. Once we receive and confirm your request, we will delete (and direct our service providers to delete) your Personal Information from our records, unless an exception applies.</p>
<p>We may not be able to honor your deletion request if retaining the information is necessary for us or our service provider(s) to:</p>
<ol>
<li>Complete the transaction for which we collected the Personal Information, provide a good or service that you requested, take actions reasonably anticipated within the context of our ongoing business relationship with you, or otherwise perform our contract with you.</li>
<li>Detect security incidents, protect against malicious, deceptive, fraudulent, or illegal activity, or prosecute those responsible for such activities.</li>
<li>Debug products to identify and repair errors that impair existing intended functionality.</li>
<li>Exercise free speech, ensure the rights of other consumers to exercise their free speech rights, or exercise another right provided for by law.</li>
<li>Comply with the extant laws.</li>
<li>Engage in public or peer-reviewed scientific, historical, or statistical research in the public interest that adheres to all other applicable ethics and privacy laws, when the business' deletion may likely render impossible or seriously impair the research's achievement, if you previously provided informed consent.</li>
<li>Enable solely internal uses that are reasonably aligned with consumer expectations based on your relationship with us.</li>
<li>Comply with a legal obligation.</li>
<li>Make other internal and lawful uses of that information that are compatible with the context in which you provided it.</li>

</ol>

<p><strong>Exercising Your Right to Know and Right to Delete </strong></p>
<p>To exercise the access and deletion rights described above, please submit your request to us at info@Brixmarket.com, or contact us in writing at the address listed below in this Privacy Policy. Only you, or an authorized agent registered with the Local Secretary of State that you authorize to act on your behalf, may make a consumer request related to your Personal Information. You may also make a consumer request on behalf of your minor child (13 and under). If you have any questions about your access or deletion rights described above, you may also contact us via email or regular mail at the contact information contained below in this Privacy Policy.</p>
<p>You may only make a Right to Know request twice within a 12-month period. We cannot respond to your request to delete or provide you with Personal Information if we cannot verify your identity or your authority to make the request and confirm the Personal Information relates to you. We will only use Personal Information provided in a verifiable consumer request to verify the requestor's identity or authority to make the request.</p>
<p><strong>Response Timing and Format</strong></p>
<p>Where possible, we will respond to a verified consumer request within forty-five (45) days of its receipt; however, if we require more time, we will inform you of the reason and extension period. 
Any disclosures we provide will only cover the 12-month period preceding the verified consumer request's receipt. The response we provide will also explain the reasons we cannot comply with a request, if applicable. For data portability requests, we will select a format to provide your Personal Information that is readily useable and should allow you to transmit the information from one entity to another entity without hindrance. 
We do not charge a fee to process or respond to your verifiable consumer request unless it is excessive, repetitive, or manifestly unfounded. If we determine that the request warrants a fee, we will tell you why we made that decision and provide you with a cost estimate before completing your request.</p>

<p><strong>Personal Information Sales Opt-Out and Opt-In Rights </strong></p>
<p>We do not disclose your Personal Information to any third-party in a manner that would be considered a sale under the Law. </p>

<p><strong>Non-Discrimination</strong></p>
<p>We will not discriminate against you for exercising any of your fundamental human rights. Unless permitted by law, we will not:</p>
<ol>
<li>Deny you goods or Marketplace</li>
<li>Charge you different prices or rates for goods or Marketplace, including through granting discounts or other benefits, or imposing penalties.</li>
<li>Provide you a different level or quality of goods or Marketplace.</li>
<li>Suggest that you may receive a different price or rate for goods or Marketplace or a different level or quality of goods or Marketplace. </li>
</ol>
<p>However, we may offer you certain financial incentives permitted by Law that can result in different prices, rates, or quality levels. Any LAW-permitted financial incentive we offer, will reasonably relate to your Personal Information's value to us and contain written terms that describe the program's material aspects. Participation in a financial incentive program requires your prior opt-in consent, which you may revoke at any time. If any Law permits users of our Site/App and Marketplace who are Local residents to request certain information regarding our disclosure of Personal Information to third parties for their direct marketing purposes. To make such a request, please contact us using the contact information provided below in this Privacy Policy.</p>
<p><strong>B. Children </strong></p>
<p>Our Site/App and Marketplace are not directed to children under 13 (or other age as defined by local law), and we do not knowingly collect Personal Information from children. If you learn that your child has provided us with Personal Information without your consent, you may contact us at the email address below with the subject line " Child Information Request." If we learn that we have collected any Personal Information from a child in violation of applicable law, we will promptly take steps to delete such information.</p>
<p><strong>C. Supervisory Authority </strong></p>
<p>If you are located in the European Economic Area, you have the right to lodge a complaint with a supervisory authority if you believe our processing of your Personal Information violates applicable law.</p>
<p><strong>D. Links to Third Party Site/Applications </strong></p>
<p>The Marketplace may contain links to other website/applications and other websites/applications may reference or link to our Site/App or other Marketplace. These other websites and applications are not controlled by us. We encourage our users to read the privacy policies of each website and application with which they interact. Brixmarket does not endorse, screen or approve, and are not responsible for the privacy practices or content of such other websites/ applications. Visiting these other websites/applications is at your own risk.</p>
<p><strong>E. Changes to this Privacy Policy </strong></p>
<p>Brixmarket may revise this Privacy Policy from time to time in our sole discretion. If there are any material changes to this Privacy Policy, we will notify you as required by applicable law, which may include updating our notice on our Site/App. You understand that you will be deemed to have accepted the updated Privacy Policy if you continue to use the Marketplace after the new Privacy Policy takes effect</p>


<p><strong>Contact Us</strong></p>
<p>If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us through <strong>Grievance / Compliance Officer &nbsp;</strong><a href="mailto:Support@brixmarket.com%20or%20Officialbrixmarket@gmail.com">Support@brixmarket.com or Officialbrixmarket@gmail.com</a></p>
                        </div>
                    </div>

                </div>
            </div>
        </section>
        
                          '''));
}
