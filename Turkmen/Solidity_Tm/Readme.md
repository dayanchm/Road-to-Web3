 # Solidity Kursy

<img src="image/logo.svg" align="center" alt="drawing" width="200"/>

Solidity, Akylly şertnamalary ýerine ýetirmek üçin obýekte gönükdirilen, ýokary derejeli programmirleme dilidir. Akylly şertnamalar, Ethereum ulgamyndaky amallaryň özüni alyp barşyny dolandyrýan programmalar.

Solidity C ++, Python we JavaScript tarapyndan ylham alyndy we Ethereum Wirtual Machine (ESM) nyşana alyndy.

Solidity statik şekilde ýazylandyr.Beýleki bar aýratynlyklarynyn ýanynda, obýektler arasynda miras aragatnaşyklary, kitaphanalary we ulanyjy kesgitlän çylşyrymly görnüşleri goldaýar.

Bu diliň kömegi bilen ses bermek, köpçülikleýin pul ýygnamak, auksion we köp golly gapjyklar ýaly ulanyş üçin şertnamalar döredip bilersiňiz.

Şertnamalar ýerleşdirilende, çykan Solidity-iň iň soňky wersiýasyny ulanmaly. Sebäbi üýtgeşmeler bilen birlikde täze aýratynlyklar we näsazlyklary düzetmek yzygiderli çykýar.Bu çalt
[üýtgeşme we ösüş döwründe ulanýan wersiýamyzy görkezmek üçin](https://semver.org/#spec-item-4) 0.x wersiýa belgisini ulanýarys.


### Dil resminamalary
Akylly şertnamalar düşünjesine täze gelen bolsaňyz, Solidity-da ýazylan akylly şertnamadan başlamagy maslahat berýäris.Has giňişleýin maglumat üçin taýyn bolanyňyzda, diliň esaslaryny öwrenmek üçin "Çydamlylyk mysallary" we "Çuňlugyň çuňlugy" bölümlerini okamagyňyzy maslahat berýäris.

Has giňişleýin maglumat üçin “Ethereum” wirtual maşynynyň blokirleme esaslaryny we jikme-jikliklerini gözden geçirip bilersiňiz.

### [Maslahat](#)
> Remix IDE bilen brauzeriňizdäki kod nusgalaryny elmydama synap bilersiňiz. Remiks, Solidity bilen akylly şertnamalary ýazmaga, soňra akylly şertnamalary işletmäge we dolandyrmaga mümkinçilik berýän web brauzer esasly IDE. Loadüklemek üçin birneme wagt gerek bolup biler, şonuň üçin sabyr ediň.

### [Maslahat](#)
> Programma üpjünçiligi adamlar tarapyndan ýazylanlygy sebäpli, kemçilikleri öz içine alyp biler. Akylly şertnamalaryňyzy ýazanyňyzda kabul edilen programma üpjünçiligini işläp düzmek düzgünlerine eýermek maslahat berilýär; muňa kod gözden geçirmek, synaglar, barlaglar we takyklygyň subutnamalary girýär. Akylly şertnama ulanyjylary käwagt awtorlaryna garanyňda koda has köp ynanýarlar. Blokain we akylly şertnamalarda aýratyn üns berilmeli aýratyn meseleler bar; Öndüriji hökmünde islendik koduň üstünde işlemezden ozal ** Howpsuzlyk pikirleri ** bölümini okap bilersiniz.

Soraglaryňyz bar bolsa, jogap üçin onlaýn çeşmelerden gözläp bilersiňiz, [Ethereum Stackexchange] (https://ethereum.stackexchange.com/) ýa-da (https://gitter.im/ethereum) -da sorap bilersiňiz. / berklik /)) synap görüp bilersiňiz.

Bu resminamalary gowulandyrmak üçin berklik ýa-da pikirler elmydama kabul edilýär. Bu mowzuk barada has giňişleýin maglumat üçin [goşant goşýanlar gollanmasyny] okaň (https://solidity.readthedocs.io/en/v0.5.3/contributing.html).

## Terjimeler

Jemgyýetiň käbir meýletinçileri bu resminamany dürli dillere terjime etmekde bize kömek edýärler. Şol sebäpli terjimelerde dürli derejedäki bitewilik we öz wagtynda bolýar. Iňlis dilindäki wersiýa salgylanma hökmünde ulanylýar.

+ [Simplified Chinese](https://solidity-cn.readthedocs.io/zh/develop/)
+ [Spanish](https://solidity-es.readthedocs.io/)
+ [Russian](https://github.com/ethereum/wiki/wiki/%5BRussian%5D-%D0%A0%D1%83%D0%BA%D0%BE%D0%B2%D0%BE%D0%B4%D1%81%D1%82%D0%B2%D0%BE-%D0%BF%D0%BE-Solidity) 
+ [Korean](http://solidity-kr.readthedocs.io/)
+ [French](http://solidity-fr.readthedocs.io/)

## Mazmuny

+ Akylly Şertnamalara Giriş
  - Smartýönekeý akylly şertnama
  - Blokirlemegiň esaslary
  - Ethereum wirtual maşyn
+ Solidity Compiler gurmak
  - Wersiýa
  - Remiks
  - Npm / Node.js
  - Doker
  - Ikilik paketler
  - Çeşmeden gurnamak
  - CMake opsiýalary
  - Jikme-jik wersiýa setiri
  - Wersiýa barada möhüm maglumatlar
+ Gaty mysallar
  - Ses bermek
  - Hususy auksion
  - Uzakdan satyn almak
  - Mikro töleg kanaly
+ Çuňlugyň berkligi
  - Çydamly çeşme faýlynyň gurluşy
  - Şertnamanyň gurluşy
  - Şertnamanyň görnüşleri
  - Bölümler we dünýäde elýeterli üýtgeýjiler
  - Beýannamalar we dolandyryş gurluşlary
  - Şertnamalar
  - Gatylyk ýygnagy
  - Dürli
  - Gatylyk v0.5.0 Üýtgeşmeler
+ Howpsuzlyk meselesi
  - Duzaklar
  - Teklipler
  - Resmi tassyklama
+ Çeşmeler
  - General
  - Gaty integrasiýa
  - Gaty gurallar
  - Üçünji tarapyň berkligi we şertleri
+ Kompilýeri ulanmak
  - Buýruk setirini düzüjini ulanmak
  - EVM wersiýasyny nyşana düzmek
  - Kompilýatoryň giriş we çykyş JSON beýany
+ Şertnamanyň meta-maglumaty
  - Baýt kodunda Metadata Haşyny kodlamak
  - Awtomatiki UI öndürmek we NatSpec ulanylyşy
  - Çeşme koduny barlamak
+ Şertnama ABI aýratynlyklary
  - Esasy dizaýn
  - Funksiýany saýlamak
  - Argument kodlamagy
  - görnüşleri
  - Kodlaşdyrmagyň dizaýn ölçegleri
  - Kodlaşdyrmagyň resmi spesifikasiýasy
  - Funksiýany saýlamak we argument kodlamak
  - Mysallar
  - Dinamiki görnüşleri ulanmak
  - Wakalar
  - JSON
  - Kodlaşdyrmagyň berk tertibi
  - Standart däl gaplama tertibi
+ Ulul
  - ulul spesifikasiýasy
  - “ulul” obýektiniň aýratynlyklary
+ Stil gollanmasy
  - Giriş
  - Kod düzülişi
  - Layout yzygiderliligi
  - Konwensiýalary atlandyrmak
  - NatSpec
+ Umumy nagyşlar
  - Şertnamalardan çykarmak
  - Girişi çäklendirmek
  - Döwlet mehanizmi
+ Belli buglaryň sanawy
+ Goşant goşmak
  - Meseleleri nädip habar bermeli?
  - Pull & Push haýyşlary üçin iş tertibi
  - Kompilýator synaglary
  - AFL bilen Fuzzer-i işletmek
  - Çybyklar
+ Freygy-ýygydan soralýan soraglar
  - Esasy soraglar
  - Giňişleýin soraglar
+ LLL

