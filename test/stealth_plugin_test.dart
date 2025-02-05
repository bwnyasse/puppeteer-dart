import 'package:puppeteer/plugins/stealth.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:test/test.dart';
import 'utils/utils.dart';

main() {
  Server server;
  setUpAll(() async {
    server = await Server.create();
  });

  tearDownAll(() async {
    await server.close();
  });

  tearDown(() async {
    server.clearRoutes();
  });

  test('Stealth plugin', () async {
    var browser = await puppeteer.launch(plugins: [StealthPlugin()]);
    expect(browser.plugins, hasLength(1));
    var page = await browser.newPage();

    await page.goto(server.emptyPage);
    String ua = await page.evaluate('window.navigator.userAgent');
    expect(ua.toLowerCase(), contains('chrome'));
    expect(ua.toLowerCase(), isNot(contains('headless')));

    await browser.close();
  });
}
