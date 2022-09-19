import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import '../widgets/footer_page.dart';
import '../widgets/main_drawer.dart';
import '../widgets/mobile_appbar.dart';

class TermsWeb extends StatelessWidget {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  TermsWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainPadding = Get.width < 480 ? Get.width * 0.05 : Get.width * 0.06 + Get.width * 0.009;
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
                      decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/hero1.jpg'))),
                      child: Container(
                        width: Get.width,
                        height: isMobile() ? 140 : 300,
                        color: Colors.black.withOpacity(0.7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'Terms and Conditions',
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
                        termsContent(),
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

termsContent() {
  return const HtmlWidget('''
                          <section class="about-area ptb-70">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-12">
                        <div class="about-content">
                           <p>&nbsp;</p>
<p>Brixmarket is operated by&nbsp;<a href="http://www.dilmaksolutions.com/">Shua Properties Limited</a>. By using this app/website and the services contained therein ('Services') you agree to comply with and be bound by the following terms and conditions ('Terms of Use'). If you do not agree to and accept these Terms of Use, you should not use this app/app/website. All references within these Terms of Use to 'we/us/our' refer to Brixmarket.</p>
<p><strong>&nbsp;</strong></p>
<p><strong>Usage Restrictions</strong></p>
<ol>
<li>You agree not to transmit any material designed to interrupt, damage, destroy or limit the functionality of our app/website or the Services.</li>
<li>You agree not to use any automated software to view the Services without consent and to only access our Services manually.</li>
<li>You agree not to use the Services other than for your own personal use or as an agent listing property for sale and to rent.</li>
<li>You agree not to attempt to copy our data or reverse engineer our processes without our consent.</li>
<li>You agree not to use our Services in any manner that is illegal, immoral or harmful to us.</li>
<li>You agree not to use our Services in breach of any policy or other notice on our app/website.</li>
<li>You agree not to remove or alter any copyright notices that appear on our app/website.</li>
<li>You agree not to publish any material that may encourage a breach of any relevant laws or regulations.</li>
<li>You agree not to interfere with any other user's enjoyment of our app/website or the Services.</li>
<li>You agree not to transmit materials protected by copyright without the permission of the owner.</li>
<li>You agree not to conduct yourself in an offensive or abusive manner whilst using our app/website or the Services.</li>
<li>You agree not to attempt to bypass restrictions on user accounts.</li>
</ol>
<p>&nbsp;</p>
<p><strong>Security and Registration</strong></p>
<p>You must be over <strong>sixteen</strong> years of age to register on our app/website and must ensure that the details provided by you on registration are true, accurate, current and complete. It is your responsibility to update and inform us of any changes to the details provided on registration. Although certain parts of our app/website may be used by anyone who visits without requiring registration, some of the Services require you to register in order to enable us to verify your identity.</p>
<p>By registering with the service, you agree that we can send you emails about your account, other Brixmarket services and occasional third party offers.</p>
<p>When registering, you will be asked to create a password and will be responsible for maintaining the confidentiality of your password and restricting access to your computer, as you will be accountable for any activities conducted under your password. If you believe that someone has accessed your account without authorization, please contact us immediately.</p>
<p><strong>Materials You Provide</strong></p>
<p>By submitting content on our app/website or otherwise providing content to us in connection with the Services ('Materials'), you grant us a royalty-free, perpetual, irrevocable and non-exclusive right and license to</p>
<p>(a) use, reproduce, distribute, display, modify and edit these Materials in connection with the Services and</p>
<p>(b) sublicense these rights. We will not pay you any fees for these Materials and reserve the right in our sole discretion to remove or edit them at any time. You also warrant and represent that you have all rights necessary to grant us these rights. We permit you to post Materials on our app/website in accordance with our procedures provided that the content is not illegal, obscene, abusive, threatening, defamatory or otherwise objectionable to us.</p>
<p><strong>Advertising Property On App/website</strong></p>
<p>Property adverts/listings placed on our app/website must contain details of only one property in Nigeria per advert/listing. We reserve the right to either split adverts/listings that breach this term into single property adverts/listings or disable such adverts/listings.</p>
<p><strong>Charges And Payments</strong></p>
<p>All charges and payments for services on Brixmarket are non-refundable.</p>
<p><strong>Your Responsibilities</strong></p>
<p><strong><u>We are not an estate agency and we provide a service whereby agents may market and you may view property details ('Details') together with other content hosted and developed by us. Agents are responsible for preparing the Details and fielding enquiries directly from you. We do not get involved in any communications between you and agents and we do not participate in any part of the transaction.</u></strong></p>
<p>Details are hosted by us in good faith but are produced directly by agents and have not been verified by us. You are responsible for making your own enquiries and we provide no guarantee and accept no responsibility for the accuracy or completeness of any information contained within the details.</p>
<ol>
<li>You are responsible for checking, confirming and satisfying yourself as to the accuracy of any Details.</li>
<li>You are responsible for instructing a surveyor and obtaining legal advice before committing to any purchase.</li>
<li>You are responsible for ensuring that you act in good faith towards any other parties.</li>
</ol>
<p>&nbsp;</p>
<p><strong>Availability Of App/website</strong></p>
<p>We strive to ensure that our app/website and the Services are available to you at all times but cannot guarantee that either the app/website or the Services will operate continuously, without interruptions or be fault free. On occasion, necessary maintenance or upgrade work requires us to make the app/website and the Services unavailable without notice, but we aim to keep downtime to a minimum. We accept no liability for any interruption or loss of service. We reserve the absolute right to alter, suspend or discontinue any part of our app/website or the Services, including your access to it.</p>
<p><strong>Third Parties</strong></p>
<p>Our app/website may contain links to third party products, services and/or app/websites that are not affiliated with us. We have no control over the products, services or app/websites of these third parties and we do not guarantee or take responsibility for them. Our app/website may also contain advertising from third parties and we are not responsible for any misleading or inaccurate advertisements which are the sole responsibility of the advertiser. Any links or advertisements on our app/website should not be taken as an endorsement by us of any kind. Furthermore, our app/website contains data provided by third parties and we accept no responsibility for any inaccuracies in this material. You agree to release us from any claims or disputes of any kind arising from or in any way connected to such disputes with third parties.</p>
<p><strong>&nbsp;</strong></p>
<p><strong>Disclaimer</strong></p>
<p>The Services are provided on an 'as is' and 'as available' basis and we make no representations or warranties of any kind, either express or implied. You expressly agree that your use of our app/website and the Services is at your sole risk and we expressly disclaim any and all warranties, either express or implied, including without limitation warranties as to quality, suitability for any purpose, compatibility, reliability, accuracy, completeness, timeliness, access or use. We accept no responsibility and make no guarantee that the Services will be free from faults, errors and/or omissions. It is your sole responsibility to evaluate the quality, suitability, accuracy, completeness and reliability of the Services or any information provided.</p>
<p>The value estimates provided on our app/website are intended for general interest and information purposes only and should not be relied upon for any commercial transaction or similar use. These estimates are based on a) publicly available information which may be inaccurate or incomplete and b) typical properties in certain locations. They will not take account of any factors which are unknown to us and should therefore only be used as a starting guide to help determine what a home might be worth. None of the Services are intended to be a substitute for independent professional advice and users are recommended to seek advice from suitably qualified professionals such as surveyors and solicitors if relevant to their particular circumstances. We shall not be liable for any losses suffered as a result of relying on our value estimates.</p>
<p>Property descriptions and other information provided on our app/website are intended for information and marketing purposes and, whilst displayed in good faith, we will not in any circumstances accept responsibility for their accuracy. It is the responsibility of buyers to satisfy themselves as to the accuracy of any property descriptions and the responsibility of agents to ensure the accuracy of any descriptions provided.</p>
<p><strong>Limitation Of Liability</strong></p>
<p>In no event shall we nor any of our officers, shareholders, directors, employees, agents or suppliers be liable for any loss or direct, indirect, consequential, incidental, special or any other damages arising from your use of the Services. Should you not agree with any part of these Terms of Use or have any dispute or claim against us or our suppliers with respect to these Terms of Use or the Services, your sole and exclusive remedy will be to discontinue using the Services.</p>
<p><strong>Indemnification</strong></p>
<p>You agree to indemnify, defend and hold us and our affiliated companies, shareholders, officers, directors, employees, agents or suppliers harmless from any and all claims or demands, made by any third party due to or arising out of your use of the Services, the violation of these Terms of Use by you, or the infringement by you of any intellectual property or other right of any other person or entity.</p>
<p><strong>Changes To Terms Of Use</strong></p>
<p>We reserve the right in our sole discretion to change these Terms of Use at any time without prior notice to you. Any changes will be posted on our app/website and become effective at the time of posting. Your continued use of the Services after the effective date of such changes will constitute acceptance of and agreement to any such changes. We reserve the right to modify, suspend or discontinue all or part of the Services at any time to you and/or others, with or without notice. We shall not be liable to you or any other party should we exercise our right to modify, suspend or discontinue all or part of the Services.</p>
<p><strong>Applicable Law</strong></p>
<p>These Terms of Use shall be governed by and construed in accordance with Nigerian law and the parties agree that any disputes will be settled in Nigerian courts. Should any provision of these Terms of Use be determined to be invalid or unenforceable by any court having competent jurisdiction, then the invalid or unenforceable provision will be replaced with a provision that reflects the intent of the original provision, to the extent permitted by applicable law and all other provisions of these Terms of Use shall remain in full force and effect.</p>
<p><strong>General</strong></p>
<p>The headings in these Terms of Use are solely used for convenience and have no legal or contractual significance. We may assign this Agreement, in whole or in part, at any time without notice to you and upon such assignment will be relieved of any further obligation under these Terms of Use. You may not assign, transfer or sublicense your rights, if any, under these Terms of Use. Our delay or failure to exercise or enforce any right or provision of these Terms of Use with respect to a breach by you or others shall not constitute or be construed as a waiver of such right to act. We shall not be responsible for any breach of these Terms of Use caused by circumstances beyond our control.</p>
<p>These Terms of Use together with the Privacy Policy constitute the entire agreement between you and us with respect to the Services and supersede any and all prior agreements and understandings between you and us.</p>
<p>At Shua Properties Limited represented by Brixmarket, you always come first. As a result, we do not publish, sell or rent any of your personal data to a third party without your consent.</p>
<p><strong>Privacy Policy on Personal Information and Data</strong></p>
<p>We respect and are committed towards protecting your privacy. Publishing, selling or renting any personal data or information to any third party, without your consent, is against our ethic.</p>
<p>For more clarity on how we use and protect your personal information, please go through our privacy policy thoroughly!</p>
<p>Our privacy policy is subject to change at any time without notice. To make sure you are aware of any changes, please review this policy.</p>
<p>The privacy practices of this statement apply exclusively to our services available under the domain and sub-domains of Brixmarket and apply generally to our parent, affiliates, subsidiaries or joint venture app/websites. By visiting this app/website you agree to be bound by the terms and conditions of this Privacy Policy. If you do not agree please do not use or access our app/website.</p>
<p>By accepting the Privacy Policy and the Terms &amp; Conditions Agreement while registration, you expressly consent to our use and disclosure of your personal information in accordance with this Privacy Policy. This Privacy Policy is effective upon acceptance during registration, and is otherwise effective on carrying out any transaction with us for all users.</p>
<p>In the course of registering for and availing various services we provide from time to time through our app/website (App/website, telephone search, SMS and WAP) or any other Media medium in which Brixmarket may provide services you may be required to disclose your name, residence address, email address, telephone number and similar Personal Information.</p>
<p>The type of information we will collect about you includes:</p>
<p>The Personal Information is used for two general purposes: to process your order, and to provide you with the best possible services. Unless otherwise stated explicitly, this Policy applies to Personal Information as disclosed on any of the Media.</p>
<p><strong>Cookies</strong></p>
<p>Cookies are files with small amount of data that is commonly used an anonymous unique identifier. These are sent to your browser from the app/website that you visit and are stored on your devices&rsquo; internal memory.</p>
<p>This Services does not use these &ldquo;cookies&rdquo; explicitly. However, the app may use third party code and libraries that use &ldquo;cookies&rdquo; to collection information and to improve their services. You have the option to either accept or refuse these cookies, and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.</p>
<p>In furtherance of the confidentiality with which we treat Personal Information we have put in place appropriate physical, electronic, and managerial procedures to safeguard and secure the information we collect online. We use data collection devices such as &ldquo;cookies&rdquo; on certain pages of the Site to help analyze our web page flow, measure promotional effectiveness, and promote trust and safety. "Cookies" are small files placed on your hard drive that assist us in providing our services. We offer certain features that are only available through the use of a "cookie". We also use cookies to allow you to enter your password less frequently during a session. Cookies can also help us provide information that is targeted to your interests. Most cookies are "session cookies," meaning that they are automatically deleted from your hard drive at the end of a session. You are always free to decline our cookies if your browser permits, although in that case you may not be able to use certain features on the Site and you may be required to reenter your password more frequently during a session.</p>
<p>Additionally, you may encounter "cookies" or other similar devices on certain pages of the Site that are placed by third parties. For example, if you view a web page created by a user, there may be a "cookie" placed within that web page. We do not control the use of cookies by third parties.</p>
<p>If you send us personal correspondence, such as emails or letters, or if other users or third parties send us correspondence about your activities or postings on the App/website, we may collect such information into a file specific to you.</p>
<p>We use third-party service providers to process purchases you make and to monitor our users' interests. In addition, the App/website may occasionally contain links to Third-Party Sites. If you click on the links to Third-Party App/websites, you leave the App/website. We are not responsible for the content of these Third-Party App/websites or for the security of your personal information when you use the Third-Party App/websites. These third-party service providers and Third-Party Sites may have their own privacy policies governing the storage and retention of your personal information that you may be subject to. They may collect information such as your IP address, browser specification, or operating system. This Privacy Policy does not govern personal information provided to, stored on, or used by these third-party providers and Third-Party Sites. We recommend that when you enter a Third-Party Site, you review the Third-Party Site's privacy policy as it relates to safeguarding your personal information. We use third-party advertising companies to serve ads when you visit the App/website. These companies may use information (not including your name, address, email address, or telephone number) about your visits to the App/website and Third-Party App/websites in order to provide advertisements about goods and services of interest to you.</p>
<p>You acknowledge that you are disclosing Personal Information voluntarily. Prior to the completion of any registration process on our app/website or prior to availing of any services offered on our app/website if you wish not to disclose any Personal Information you may refrain from doing so; however if you don't provide information that is requested it is possible that the registration process would be incomplete and/or you would not be able to avail of the our services.</p>
<p>We identify and use your IP address to help diagnose problems with our server, and to administer our App/website. Your IP address is also used to help identify you and to gather broad demographic information.</p>
<p><strong><u>Data Retention and Deletion</u></strong></p>
<p><br /> We retain your personal information as long as necessary for us to provide services to you or you ask us to not retain your data. If you no longer want us to use your information then you can request us via email on&nbsp;<a href="mailto:Support@brixmarket.com%20or%20Officialbrixmarket@gmail.com">Support@brixmarket.com or Officialbrixmarket@gmail.com</a> that we erase your personal information. We will process your request and send you a confirmation via email. Please note that we may retain some of your personal information to the extent necessary to comply with our legal obligations or as necessary for our legitimate business interests, such as fraud detection and prevention and enhancing safety.</p>
<p><strong><u>Withdrawing Consent</u></strong></p>
<p><br /> For withdrawing your consent at any time during the tenure of your services with us, you may choose to do so by sending us an e-mail. We shall review your request and may ask you to verify your identity. Post verification we will withdraw the consent for which request was made by you and stop any further processing of your personal information.</p>
<p><strong><u>Mobile Privacy</u></strong></p>
<p><br /> We may offer you the ability for you to connect with our sites, or use our applications, services, and tools using a mobile device, either through a mobile application or via a mobile optimized app/website. The provisions of this Privacy Policy apply to all such mobile access and use of mobile devices. This Privacy Policy will be referenced by all such mobile applications or mobile optimized app/websites.</p>
<p><strong><u>Your Privacy - Our Commitment</u></strong></p>
<p><br /> Brixmarket through its app/website, is extremely proud of its commitment to protect your privacy. We value your trust in us. We will work hard to earn your confidence so that you can enthusiastically use our services and recommend us to friends and family. Please read the policy to understand how your personal information will be treated as you make full use of our App and website.</p>
<p><strong><u>Privacy Guarantee</u></strong></p>
<p><br /> Brixmarket promises that we will not sell or rent your personal information to third parties for their marketing purposes without your explicit consent. Your trust and confidence are our highest priority. Personal Information may be shared only under one or more of the following circumstances:</p>
<p>(a)If we have your consent or deemed consent to do so;<br /> (b) If we are compelled by law (including court orders) to do so.</p>
<p>Brixmarket gives you the ability to edit your account information and preferences at any time. To protect your privacy and security, we will also take reasonable steps to verify your identity before granting access or making corrections.</p>
<p>While we strive to use a commercially acceptable means to protect the personal information you provide, we cannot guarantee its security. Therefore, you acknowledge and agree that we assume no liability regarding the theft, loss, alteration or misuse of personal or other information or Content, including, without limitation, such information that has been provided to third parties or other users, or with regards to the failure of a third party to abide by the agreement between us and such third party.</p>
<p>Further, you have the right to refuse any marketing email from us or any other trader in the future.</p>
<h2><strong>Additional Privacy Policy</strong>&nbsp;</h2>
<p>Brixmarket is built by Shua Properties Limited as a both freemium and premium app. Some of the service is provided by Brixmarket at no cost for the freemium option and pre-payment of a stipend for the Premium option&nbsp; &nbsp;and is intended for use as is.</p>
<p>This page is used to inform app users or website visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.</p>
<p>If you choose to use our Service, then you agree to the collection and use of information in relation with this policy. The Personal Information that we collect are used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.</p>
<p>The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Brixmarket, unless otherwise defined in this Privacy Policy.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><strong>Information Collection and Use</strong></p>
<p>For a better experience while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to e.g. users name, address, location and pictures. The information that we request will be retained by us and used as described in this privacy policy.</p>
<p>The app does use third party services that may collect information used to identify you.</p>
<ol>
<li><a href="https://www.google.com/policies/privacy">Google Private Policy</a></li>
<li><a href="https://www.facebook.com/legal/FB_Work_Privacy">Facebook Privacy Policy</a></li>
<li><a href="https://www.facebook.com/legal/FB_Work_Privacy">Instagram Privacy Policy</a></li>
</ol>
<p><strong>Log Data</strong></p>
<p>We want to inform you that whenever you use our Service, in case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your devices&rsquo; Internet Protocol (&ldquo;IP&rdquo;) address, device name, operating system version, configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.</p>
<p><strong>&nbsp;</strong></p>
<p><strong>Service Providers</strong></p>
<p>We may employ third-party companies and individuals due to the following reasons:</p>
<ul>
<li>To facilitate our Service;</li>
<li>To provide the Service on our behalf;</li>
<li>To perform Service-related services; or</li>
<li>To assist us in analyzing how our Service is used.</li>
</ul>
<p>We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.</p>
<p><strong>&nbsp;</strong></p>
<p><strong>Security</strong></p>
<p>We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.</p>
<h3><strong>&nbsp;</strong></h3>
<h3><strong>Termination of Use or Access</strong></h3>
<p>Brixmarket may terminate your account or use of the App/Website at any time for any reason, including, without limitation, if you are in breach of these Terms of Sale or the App/Website Policies, or if the App/Website is no longer operated by Brixmarket. By using the App/Website, you agree to be responsible (in accordance with these terms) for any orders you make or charges you incur prior to such termination. Brixmarket may change, discontinue, or otherwise suspend the App/Website at any time, for any reason, and without prior notice to you.</p>
<p>&nbsp;</p>
<h3><strong>Warranties and Limitation of Remedies</strong></h3>
<p><strong>&nbsp;</strong></p>
<p><strong>Except where prohibited by your applicable local law, Brixmarket and its Advertisers, App/Website&rsquo; members, and content providers disclaim all express and implied warranties, guarantees, and conditions, including for merchantability, satisfactory quality, fitness for a particular purpose, workmanlike effort, title, or non-infringement. Products or Services sold or available through the App/Website are NOT warranted, if at all, only under any license agreements or manufacturer&rsquo;s warranties that accompany them. Except as provided under an accompanying license agreement or manufacturer&rsquo;s warranty:</strong></p>
<ul>
<li><strong>Your purchase and use are at your own risk;</strong></li>
<li><strong>We provide only platform for Products and Services "as is," "with all faults," and "as available";</strong></li>
<li><strong>You assume the entire risk as to their quality and performance; and</strong></li>
<li><strong>Should they prove defective or deceptive, you assume the entire cost of attribution with all necessary attendant implications or consequences.</strong></li>
</ul>
<p><strong>Brixmarket does NOT guarantee the accuracy or timeliness of information available from the App/Website or Services. You acknowledge that computer and telecommunications systems are not fault-free and occasional downtime occurs. We do not warrant that access to the App/Website or Services will be uninterrupted, timely, secure, or error-free, or that content loss won&rsquo;t occur.</strong></p>
<p><strong>&nbsp;</strong></p>
<p><strong>Links to Other Sites</strong></p>
<p>This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, I strongly advise you to review the Privacy Policy of these app/websites. I have no control over, and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.</p>
<p><strong><u>Children's Privacy</u></strong></p>
<p><br /> The Brixmarket's app/website is a general audience app/website, and it and its related sites, applications, services, and tools are not intended for children under the age of <strong>16</strong>. This Service do not address anyone under the age of <strong>16</strong>. We do not knowingly collect personal identifiable information from children under <strong>16</strong>. In the case we discover that a child under <strong>16</strong> has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions.</p>
<p><strong>Errors in Presentation</strong></p>
<p>We work hard to publish information accurately, update the App/Website regularly, and correct errors when discovered. However, any of the content in the App/Website may be incorrect or out of date at any given time. We reserve the right to make changes to the App/Website at any time, including to product designs, options, specifications, offers and availability.</p>
<p><strong>&nbsp;</strong></p>
<p><strong>Changes to This Privacy Policy and Updates</strong></p>
<p>If applicable, Brixmarket will automatically check for and download updates to your applications, even if you&rsquo;re not signed into the App/Website. You can change your settings if you prefer not to receive automatic updates to app/website. However, at certain period the app/website which may entirely or partly hosted online may be updated at any time by Brixmarket and may not require your permission to update. App/Website may not be accessible until you accept an update. If you choose not to download or install updates, your applications may no longer be available, supported, or have previous functionality.</p>
<p>We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately, after they are posted on this page.</p>
<p><strong>&nbsp;</strong></p>
<p><strong>Contact Us</strong></p>
<p>If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us through <strong>Grievance / Compliance Officer &nbsp;</strong><a href="mailto:Support@brixmarket.com%20or%20Officialbrixmarket@gmail.com">Support@brixmarket.com or Officialbrixmarket@gmail.com</a></p>
                        </div>
                    </div>

                </div>
            </div>
        </section>
        
                          ''');
}
