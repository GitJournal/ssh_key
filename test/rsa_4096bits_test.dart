import 'package:test/test.dart';

import 'package:ssh_key/ssh_key.dart';
import 'package:ssh_key/ssh_key_txt.dart';

//----------------------------------------------------------------
/// Default skip value for tests
///
/// To run an individual test, set [defaultSkip] to _true_
/// and explicitly set the skip value of that test to _false_.
///
/// To run all the tests, set the [defaultSkip] to _false_ and remove any
/// explicitly set skip values.

const defaultSkip = false;

//================================================================
// Example RSA key-pair with 4096 bits

final BigInt expectedPublicExponent = BigInt.from(65537);

final BigInt expectedModulus = BigInt.parse(
    '6406746248610936980596364795897992100825372391986775875107895520'
    '1993287775012881254183335765037534769623514761020738418816732748'
    '3510944124319085171486806265716527615018545767774028793992852521'
    '5577943697058413853324898426523583924511578206834948174858892878'
    '7962795779799360395824544521495522758942298374850137182719698307'
    '1948871824730723090517932743114874943644847974406809101685636404'
    '4932724334762132190731120905400791019220185052920851166639529133'
    '1480321911015575139775471648383894122461356113729687322599190357'
    '3570514093160956021013966786892380200873302190085109130330780255'
    '1703529759513852581871017891097746273738633824306145633046768311'
    '9804809355457335275420091935141797431426913252341463977335252897'
    '5378525169189178749466797462677899053814967321854471469113139879'
    '5877573218868973881370821858143628693068888578148730356038921461'
    '9673311987029492509981878307898132762422144848180050177760902493'
    '6894622003695437964345185138468313637750930355215086145633062664'
    '0889250015921779839203987004154488931939188379737089819919393935'
    '3941534542195538044565440538868291786705600527362330871750809151'
    '6223899456624812589891621098403564921291272411649161563666734445'
    '1038712458873255244013147696104441616513316278574431845699360874'
    '20162522165176447');

final BigInt expectedPrivateExponent = BigInt.parse(
    '3616839307659908851612132150062314597041932461948620379743380356'
    '9942897311441271047534599640429966452637911395520778797005988651'
    '0443534350238148117470571710926348302492579097549529537820583145'
    '2857969710297499057712659901803859774464491363603451677272827848'
    '8442368711735610966701504466275407037785482327123691586222491080'
    '9099659120365401115445969080515802419472543530480539590523905209'
    '1710345834223863875256267623754802113754190862992899453184144816'
    '9463187971127061797479483346001606950925816767562918222706636630'
    '3232706416509285607602953189518047555913612683350914256129792451'
    '2991549720653882811603581487325242483417966069122309304014082671'
    '2314843708961881915324998556913987504835641473760895481071329703'
    '9242538387000429883865225870431959511448424219802684063200226222'
    '1400767202182009390940191420945205530260970130464192112511155291'
    '8518170261186837314999842956251677110125748650950166322798434412'
    '1912019816578751792808644119067206934909420231450982076633182891'
    '6315193776375323567569617974225456979900188629121173226050304840'
    '2567501505985702363763955852656016559503992788294435539565936945'
    '0898249356579327216637889482427243055433480877796700244027858768'
    '8566121029119506174534833595059053222539903909866642832124036679'
    '65201788019781377');

final BigInt expectedIqmp = BigInt.parse(
    '2328767152614809773616647607645279422341929830011302316519426672'
    '9514391308743117957852490045311580418899286111229479881634270719'
    '3826912602890818767693682029890611567737916544445133001842782950'
    '2478924363869907028068089367980629361910614889239095022837467261'
    '0349539353029315594738486848318899818501057201279712640613612398'
    '5962344685697608034120716200660912059356924191987472409610036686'
    '1936790286097874444476239602622495425396140966886093789916304636'
    '2306409628045439154045213306957082354651245556611679978265303750'
    '2455904649455864273211974036634968886514962693850209424509072222'
    '56178773706384691219343039059177566612783');

final BigInt expectedP = BigInt.parse(
    '2572208206429866466838732188322680540600344000167847227056789297'
    '2044611673933903876055879862683192123161759221460432656630173994'
    '6225368077697991475370394212414458866897214459842177859243965147'
    '8388061754776434961218746973871791686480444066236669736803252881'
    '6841663552676959992823594554920637136774921822439685052224488210'
    '8573894607933207957078682541264093872161790404625083779202605093'
    '6135777189409349970454746076461745538024153310985124290407769495'
    '5113674563836198890729345701504016172954497723399092610995167501'
    '9591318870251037969091900418602041309546922633885540158657864691'
    '48831229763151499399300670563085550364479');

final BigInt expectedQ = BigInt.parse(
    '2490757253862926195845191849744900922604030164331071414605523895'
    '9276336556153422595091721905424163431572606795547639500177726195'
    '9494638615428654368924795958307575359600061309397833847119609895'
    '3943462683022158228800142634968483158522171512033123542534905337'
    '2283628529177783387054882591930062187571193090340738801581854736'
    '0653515966893771831868092178223920797940102753357996465513525836'
    '9077879440278590382782862931121064191300154998485504974193080937'
    '5021182698474098018192061232202238599342610336842930982195459937'
    '1040714762198186228989310835314647916563174060774958816609984439'
    '86995392666866713131002992763132451008193');

//================================================================
// Encodings of the public key

const openSshPublic4096 =
    'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCdCrMJShYltDmF0acCJ5hlmp1q'
    'EWZDhkKZmm0TP+5o8+JC61vHgzWESOHKAQ4lIRVmLHF8A1B2Z0HsIbzv6AirmhyT'
    'JoLJXbLjdgbEXVdRxPArhvw/7z9cHjeo3j/mv5RncYtMUbRqRU0Q7DLrqMt4/ClF'
    '+nmkUEDCqZ7DMsFvbcDp/4qsFRLRV+WnkKTtZ53DwZo/vXVnIwLK0VbgmyvGbt92'
    'aosJMSr/UAB1jCe9MsmvLQJAf3KxsXpdtbgX96xWGxjyoprZYav3OUezY98D7YTZ'
    'W1dtf+16R014oogEQmM3PknWFcavn2oUGKAZ7Yk76JExosaWCqFv1sGfYqpf6evj'
    'Nd0ixW8K1/d/tVH8pb3gnRwXXCHO+hd9XFB7geHcybX32larMNiNeyuSc/7slsix'
    'i7QUAuuWlBxfmE7BtZWsZiQI1pfuyYk881NKpvvFW+nsc8mPkL7snF9wzZdagp4s'
    'Oc4R/aAAFeC+2HkifFyKP/68Jl/Pd3LGacd4BZ5vrfLP/NqBRzEdWJHxulbAIY8u'
    'cAeuJ7QcwJ4BbZWpA/MuQwe3isv/fkSs0W6xXYUQTyHtLyVZiqrjGSIslG0KsUvn'
    '6/uj+c/cEig5bIvx+cscUy7WYZAvWdPg9WhCORAkHblkJ51L2wmQLK62ZCICekAn'
    '3k9nMegyoCKSrpJofw== user@example.com';

//================================================================
// Encodings of the private key

const openSshPrivate4096 = '''
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
''';

//================================================================

void groupParse4096() {
  group('parsing 4096', () {
    test(
        'OpenSSH public key',
        () => testParsePublic(
            expectedModulus, expectedPublicExponent, 4096, openSshPublic4096),
        skip: defaultSkip);

    test('OpenSSH private key', () {
      final pvt = privateKeyDecode(openSshPrivate4096);
      expect(pvt, isNotNull);

      expect(pvt, const TypeMatcher<RSAPrivateKeyWithInfo>());
      // ignore: avoid_as
      final rsaPvt = pvt as RSAPrivateKeyWithInfo;

      expect(rsaPvt.source.begin, equals(0));
      expect(rsaPvt.source.end, equals(openSshPrivate4096.length));
      expect(rsaPvt.source.encoding, equals(PvtKeyEncoding.openSsh));

      expect(rsaPvt.modulus, equals(expectedModulus));
      expect(rsaPvt.publicExponent, equals(expectedPublicExponent));
      expect(rsaPvt.d, equals(expectedPrivateExponent));
      expect(rsaPvt.p, equals(expectedP));
      expect(rsaPvt.q, equals(expectedQ));

      expect(rsaPvt.comment, equals('user@example.com'));
    });
  });
}

//================================================================
// Utility methods

RSAPublicKeyWithInfo testParsePublic(
    BigInt modulus, BigInt publicExponent, int bitLength, String s) {
  //final container = FormatSsh.parse(s);
  final k = publicKeyDecode(s);

  expect(k, const TypeMatcher<RSAPublicKeyWithInfo>());
  // ignore: avoid_as
  final rsaKey = k as RSAPublicKeyWithInfo;

  expect(rsaKey.source.encoding, equals(PubKeyEncoding.openSsh));

  expect(rsaKey.modulus, equals(modulus));
  expect(rsaKey.modulus.bitLength, equals(bitLength));
  expect(rsaKey.exponent, equals(publicExponent));
  final comments = rsaKey.properties.values(SshPublicKeyHeader.commentTag);
  expect(comments.length, equals(1));
  expect(comments.first, equals('user@example.com'));

  return rsaKey;
}

//================================================================

void main() {
  groupParse4096();
}