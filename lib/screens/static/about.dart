import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final twitterUrl = Uri.parse('https://twitter.com/');
    final facebookUrl = Uri.parse('https://facebook.com/');
    final instagramUrl = Uri.parse('https://instagram.com/');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hakkımızda"),
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/etc.jpg',
                    width: 350,
                    height: 265,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Biz Kimiz?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Biz Adıgüzel E - Ticaret, e-ticaret dünyasında sizlere benzersiz bir alışveriş deneyimi sunmayı hedefleyen bir ekibiz. Müşteri memnuniyeti ve kaliteli hizmet anlayışıyla hareket eden firmamız, teknolojinin sunduğu olanakları en iyi şekilde kullanarak müşterilerimize değer katmayı amaçlamaktadır.\n\nAdıgüzel E - Ticaret olarak, geniş ürün yelpazemiz ve güvenilir alışveriş platformumuzla müşterilerimize en iyi hizmeti sunmayı amaçlıyoruz. Müşteri odaklı yaklaşımımızla, her zaman müşterilerimizin beklentilerini aşmayı ve onların ihtiyaçlarına en uygun çözümleri sunmayı amaçlıyoruz.\nDeneyimli ve profesyonel ekibimiz, her adımda müşterilerimize destek olmak için burada. Sorularınızı yanıtlamak, taleplerinizi karşılamak ve her türlü sorunu çözmek için her zaman hazırız. \n\nBizimle alışveriş yapmanın rahatlığını ve güvenini yaşayın.\n\nAdıgüzel E - Ticaret, siz değerli müşterilerimizle uzun vadeli bir ilişki kurmayı hedefliyor ve her zaman en kaliteli ürünleri en uygun fiyatlarla sunmaya devam ediyoruz. Bizi tercih ettiğiniz için teşekkür ederiz.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 44),
                    const Text(
                      'Sosyal Medya Hesaplarımız',
                      style: TextStyle(fontSize: 21),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SocialMediaIcon(
                              icon: Icons.facebook,
                              onTap: () {
                                launchUrl(facebookUrl,
                                    mode: LaunchMode.externalApplication);
                              },
                            ),
                            const Text(
                              'Facebook',
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            SocialMediaIcon(
                              icon: Icons.flutter_dash,
                              onTap: () {
                                launchUrl(twitterUrl,
                                    mode: LaunchMode.externalApplication);
                              },
                            ),
                            const Text(
                              'Twitter',
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            SocialMediaIcon(
                              icon: Icons.photo_camera,
                              onTap: () {
                                launchUrl(instagramUrl,
                                    mode: LaunchMode.externalApplication);
                              },
                            ),
                            const Text(
                              'İnstagram',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SocialMediaIcon({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 20,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
