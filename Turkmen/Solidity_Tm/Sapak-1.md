# Akylly şertnamalara giriş

Esasy mysaldan başlalyň. Üýtgeýjä baha belläliň we oňa başga şertnama bilen girmäge synanyşalyň. Häzir hemme zada düşünmeseňiz gowy bolmaz, bu temalary has giňişleýin açarys.

```
pragma solidity >=0.4.0 <0.6.0;

contract SimpleStorage {
    uint storedData;

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns (uint) {
        return storedData;
    }
}
```
Birinji setirde deslapky kody Solidity 0.4.0 wersiýasy ýa-da işleýşini bozmaýan täze wersiýa üçin ýazylandygy aýdylýar (0.6.0 wersiýasyny öz içine almaýar). Bu, şertnamanyň başgaça hereket edip biljek ýa-da bozup biljek täze (düzüji) düzüjiniň wersiýasyna laýyk gelmeýändigini üpjün etmek üçin ulanylýar. Pseudo pragmalar, deslapky kody nädip dolandyrmalydygy barada düzüjiler üçin umumy görkezmelerdir (Mysal üçin [pragma bir gezek] (https://en.wikipedia.org/wiki/Pragma_once)).


`Solidity` şertnamasy, Ethereum torundaky belli bir salgyda ýerleşýän kodlaryň (işlemegi üpjün edýän funksiýalar) we maglumatlaryň (ýagdaýyň) ýygyndysydyr. `Uint storedData` setiri `unitD` (256 bitli bitewi san) görnüşiniň `saklanan senesi` atly döwlet üýtgeýjisini kesgitleýär. Şertnamada ulanylýan funksiýalar bilen dolandyrylyp we dolandyrylyp bilinjek maglumat bazasy barada pikir edip bilersiňiz. `Ethereum` meselesinde elmydama eýeçilik etmek şertnamasy bar. Bu ýagdaýda üýtgeýjiniň bahasyny üýtgetmek ýa-da üýtgeýjini çagyrmak üçin `set` we `get` funksiýalary ulanylyp bilner.

Döwlet üýtgeýjisine girmek üçin size `bu` prefiksi gerek däl. Beýleki dillerde bolşy ýaly.

Ethereum tarapyndan döredilen infrastruktura sebäpli bu şertnamanyň başga bir wezipesi ýok, Earther ýüzündäki islendik kişä bellän bu üýtgeýjiňize girmek. Elbetde, başga bir üýtgeşik üýtgeýjini öz içine alýan ýa-da üýtgeýjiňiziň bahasyny üýtgetmek isleýän islendik adam şuňa meňzeş şertnamany çap edip biler, emma şertnamaňyz we üýtgeýän bahaňyz senesi bilen birlikde bloknotda saklanýar. Ondan soň, diňe üýtgeýäniňizi üýtgedip bilersiňiz, giriş çäklendirmelerini nädip ýerine ýetirip boljakdygyny göreris.

### [Bellik](#)

> Şertnamanyňyzyň ähli düşündiriş bahalary (şertnamanyň atlary, funksiýa atlary we üýtgeýän atlar) ASCII nyşan toplumy bilen çäklenýär. UTF-8 kodlanan maglumatlary setir üýtgeýjilerinde saklamak mümkin.

### [Duýduryş](#)

> Unicode tekstini ulananyňyzda seresaplylyk talap edilýär, sebäbi meňzeş (ýa-da birmeňzeş) nyşanlaryň dürli kod funksiýalary bolup biler we başga bir baýt yzygiderliligi hökmünde kodlanyp bilner.

## Sub-walýutanyň mysaly

Aşakdaky şertnama iň ýönekeý usulda cryptocurrency döretmek maksady bilen ýazyldy. “Ethereum” akylly şertnamalary bilen kriptografik walýutalary döredip bolýar, ýöne diňe şertnamany döreden adam (başga çykarmak meýilnamasyny durmuşa geçirip bolýar). Tordaky islendik adam, ulanyjy ady we paroly bilen islendik ýerde hasaba alynmazdan pul iberip we birek-birege töleg alyp biler - olara diňe Ethereum açar jübüti gerek.

```
pragma solidity ^0.5.0;

contract Coin {
    // The keyword "public" makes those variables
    // easily readable from outside.
    address public minter;
    mapping (address => uint) public balances;

    // Events allow light clients to react to
    // changes efficiently.
    event Sent(address from, address to, uint amount);

    // This is the constructor whose code is
    // run only when the contract is created.
    constructor() public {
        minter = msg.sender;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance.");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
```

Bu şertnama käbir täze düşünjeleri hem hödürleýär, geliň, ýeke-ýekeden geçeliň.

`address public minter`; setiri köpçülige açyk `adres` görnüşiniň döwlet üýtgeýjisini yglan edýär. `Adres` görnüşi, arifmetiki amallara rugsat bermeýän 160 bitlik bahadyr. Bu görnüş şertnama salgylaryny ýa-da daşarky taraplaryň esasy jübütlerini saklamak üçin amatlydyr. `Public` açar söz, döwlet üýtgeýjisiniň häzirki bahasyna şertnamanyň daşyndan girmäge mümkinçilik berýän funksiýa bar. Bu üýtgeýjini beýleki şertnamalardan ulanmaga rugsat berilmeýär, bu açar söz ulanylmasa. Düzediji ýa-da dörediji tarapyndan döredilen funksiýanyň kody takmynan aşakdaky ýaly (häzirlikçe `ignore` we `view`):

```
function minter() external view returns (address) { return minter; }
```

Elbetde, şuňa meňzeş bir funksiýa goşmak, koduň işlemezligine sebäp bolup biler. Sebäbi bu ýagdaýda şol bir at bilen bir funksiýa we şol bir at bilen ` state variable` bolup biler. Logika düşünersiňiz diýip umyt edýärin.

Indiki setir `mapping (address => uint) public balances;` henizem köpçülige açyk döwlet üýtgeýjisini döredýär, ýöne bu has çylşyrymly maglumat görnüşidir. Bu görnüş şertnamadaky salgylary gol çekilmedik bitewi sanlara gabat getirmek üçin ulanylýar. Geliň, bu kartalary fiziki taýdan suratlandyrmaga synanyşalyň: Her açaryň başyndan bäri bar bolan we baýt bahasy nola deň bolan hash tablisalary hakda pikir edip bileris. Bu meňzeşlik hakda kän alada etme, sebäbi kartanyň ähli düwmeleriniň sanawyny ýa-da ähli gymmatlyklaryň sanawyny almak mümkin däl. Şonuň üçin has gowy çözgüt, umumy düşünjäni ýatda saklamakdyr (ýa-da has gowusy, sanaw düzmek arkaly ösen maglumat kartalaşdyryş görnüşini ulanyň) ýa-da bu zerur däl ulgam döretmekdir. Köpçüligiň açar sözünden emele gelen `getter` funksiýasy bu ýagdaýda birneme çylşyrymly. Bu funksiýa takmynan şuňa meňzeýär:

```
function balances(address _account) external view returns (uint) {
    return balances[_account];
}
```
Görşüňiz ýaly, bu hasaby ýekeje hasabyň balansyny aňsatlyk bilen soramak üçin ulanyp bilersiňiz.

`event Sent(address from, address to, uint amount);` setir iberiş funksiýasynyň iň soňky setirinde ýaýlyma "hadysa" diýilýär. Ulanyjy interfeýsleri (elbetde hyzmat edişleri ýaly) blokchende ýaýlyma berilýän wakalary goşmaça tölegsiz diňläp biler. Efire berlen badyna diňleýjiniň amallary yzarlamagy aňsatlaşdyrýan mukdar, wagt we şertnama argumentleri ýaly maglumatlary bar. Bu wakany diňlemek üçin aşakdaky JavaScript koduny ulanmaly bolarsyňyz (bu ýerde Coin web3.js ýa-da şuňa meňzeş modul arkaly döredilen şertnama obýekti hasaplanýar):


```
Coin.Sent().watch({}, '', function(error, result) {
    if (!error) {
        console.log("Coin transfer: " + result.args.amount +
            " coins were sent from " + result.args.from +
            " to " + result.args.to + ".");
        console.log("Balances now:\n" +
            "Sender: " + Coin.balances.call(result.args.from) +
            "Receiver: " + Coin.balances.call(result.args.to));
    }
})
```
Bu ýerde awtomatiki usulda düzülen `balances` funksiýasynyň ulanyjy interfeýsi tarapyndan çagyrylýandygyny ýadyňyzdan çykarmaň.

Constructer funksiýasy,diňe şertnama baglaşylanda kesgitlenýän we soňrak çagyrylyp bilinmeýän aýratyn bir funksiýa. Şertnamany döreden adamyň salgysyny hemişelik saklaýar: `msg` (`tx` we `block` bilen), blokirleme girmäge mümkinçilik berýän käbir häsiýetleri öz içine alýan ýörite global üýtgeýjidir. `msg.sender` elmydama dogry (daşarky) funksiýa jaňynyň gelen salgysydyr.

Netijede, şertnamanyň ahyrynda kesgitlenen we soňra ulanyjylar we beýleki şertnamalar tarapyndan çagyrylyp bilinjek funksiýalar `mint` ve `send` funksiýalarydyr. Eger `Mint` funksiýasyny şertnama döredijisinden başga biri çagyrsa, hiç hili üýtgeşiklige sebäp bolmaz. Bu, `require` diýilýän ýörite funksiýa bilen üpjün edilýär, eger argument `false` bolsa, islendik üýtgeşmäni ret edýär. Ikinji `require` çagyryşy, soňundan aşa köp ýalňyşlyklara sebäp bolup biljek teňňeleriň köp bolmazlygydyr.

Başga bir tarapdan, `sent` tordaky başga birine pul ibermek üçin islendik adam (bu cryptocurrency eýýäm) tarapyndan ulanylyp bilner. Ibermek üçin ýeterlik serişdeler ýok bolsa, `sent` jaňy şowsuz bolýar we ulanyja degişli säwlik habary iberilýär.

# Blokchain esaslary

“Blockchain” programmistlere düşünmek kyn düşünje däl. Sebäbi çylşyrymlylyklaryň köpüsi (meselem, blokirleme gazmak, ýuwmak, elliptik-egrilik kriptografiýasy, şahsyýet torlary we ş.m.) platformalar üçin belli bir aýratynlyklar we wadalar bilen üpjün etmek üçin bar. Bu düşünjelere we olaryň funksiýalaryna düşüneniňizden we kabul edeniňizden soň, esasy tehnologiýa barada alada etmeli dälsiňiz. Pikirlenmek üçin, Amazonyň AWS-ni ulanmak üçin içerde nähili işleýändigini bilmelimi? Elbetde ýok.

## İşleýşi şekli

“Blockchain” dünýä derejesinde paýlaşylýan, database'dir. Bu, islendik adamyň maglumatlar bazasyndaky işjeňligi diňe tora goşulmak arkaly görüp biljekdigini aňladýar. Maglumat bazasyndaky bir zady üýtgetmek isleseňiz, beýlekiler tarapyndan kabul edilmeli bir iş bolmaly. Hereket sözi, etmek isleýän üýtgeşmäňiziň (bir wagtyň özünde iki bahany üýtgetmek isleýändigiňizi aýdalyň) ýa asla edilmeýändigini ýa-da düýbünden ulanylmaýandygyny aňladýar. Şeýle hem, amalyňyz maglumatlar bazasyna ulanylsa-da, başga amallar ony üýtgedip bilmez.

Mysal üçin, cryptocurrency-daky ähli hasaplaryň galyndylaryny görkezýän tablisa serediň. Bir hasapdan beýlekisine geçirmek soralsa, maglumatlar bazasynyň geleşik häsiýeti, pul bir hasapdan aýrylsa, elmydama beýleki hasabyňyza goşulmagyny üpjün edýär. Sebäbine garamazdan, maksat hasabyna mukdar goşmak mümkin bolmasa, çeşme hasabyndaky mukdar hem üýtgemez.

Şeýle hem, geleşik elmydama iberiji (dörediji) tarapyndan şifrlenýär. Bu maglumatlar bazasyndaky käbir üýtgeşmelere elýeterliligi aňsatlaşdyrýar. “Cryptocurrency” mysalynda, ýönekeý barlag diňe hasabyň açarlary bolan biriniň hasabyndan pul geçirip biljekdigini kepillendirýär.

## Blok düşünjesi
Overcomeeňip geçmeli iň uly päsgelçilikleriň biri (Bitcoin nukdaýnazaryndan) "goşa çykdajyly hüjüm" diýilýär: Torda gapjyk boşatjak bolýan bir wagtyň özünde iki amal bar bolsa näme etmeli? Geleşikleriň diňe biri dogry bolup biler, adatça ilki kabul edilen. Mesele, "ilki" deň-duşlar ulgamynda obýektiw termin däl.

Gysgaça aýtsak, hiç bir ulanyjy bu barada alada etmeli däl. Jedelleri çözmek üçin ulanyjy üçin dünýä derejesinde kabul edilen hereketleriň yzygiderliligi saýlanar. Geleşikler “bloklar” diýilýän özara baglanyşykly wakalara bölüner we soňra ähli gatnaşyjy düwünleriň arasynda paýlaşylar we deň paýlanar. Iki geleşik biri-birine gapma-garşy bolsa, ikinjisi ret ediler we blokuň bir bölegi bolmaz.

Bu bloklar wagtyň geçmegi bilen çyzykly yzygiderliligi emele getirýär we "blockchain" sözüniň gelip çykan ýeri. Bloklar yzygiderli yzygiderli zynjyrlara goşulýar - Ethereum üçin bu takmynan her 17 sekuntda, täze bloklar goşulýar.

"Sargyt saýlamak mehanizminiň" bir bölegi hökmünde ("magdan gazyp almak" hem diýilýär) bloklar wagtal-wagtal yzyna gaýtarylyp bilner, ýöne şeýle amal üçin diňe zynjyryň "ujundaky" adamlar hukugy bar. Berlen blokdan näçe köp blok goşulsa, yzyna öwrülmek ähtimallygy azdyr. Şonuň üçin amallaryňyz tersine bolar we hatda petikden aýrylar, ýöne näçe köp garaşsaňyz, amalyňyzyň tersine bolmagy mümkin.

# The Ethereum Sanal Machine

## Gysgaça

Ethereum Wirtual Machine ýa-da EVM (Ethereum Wirtual Machine), Ethereum-da akylly şertnamalar üçin ulanylýan iş wagty. Bu sebit diňe bir gaçybatalga däl, eýsem bütinleý izolirlenen. EVagny, EVM-iň içinde işleýän kod, tora, haýsydyr bir faýl ulgamyna ýa-da başga daşarky amallara girip bilmeýär. Bu ýerde akylly şertnamalarda hatda beýleki akylly şertnamalara-da çäkli ygtyýarlyk bar.

## Hasaplar

Ethereumda birmeňzeş salgy meýdanyny paýlaşýan hasaplaryň iki görnüşi bar: açyk açar jübütler (ýagny adamlar) tarapyndan dolandyrylýan daşarky hasaplar we hasap bilen saklanýan kod bilen dolandyrylýan şertnama hasaplary.

Daşarky hasabyň salgysy, açar bilen kesgitlenýär, şertnamanyň salgysy bolsa şertnama baglaşylanda kesgitlenýär (döredijiniň salgysyndan we şol salgydan iberilen geleşikleriň adyndan "nonce" diýilýär).

Hasabyň kod saklaýandygyna ýa-da ýokdugyna garamazdan, iki görnüşli EVM deň derejede garalýar.

Her bir hasapda hemişelik 256 bitlik meýdan açar bahasy kartasy bar. Mundan başga-da, her bir hasapda Ether-de amallar netijesinde alyş-çalyş edilýän balans bar.

### İşler

Geleşik, bir hasapdan beýlekisine iberilen habar (şol bir ýa-da boş bolup biler, aşakda serediň). Onda ikilik maglumatlary (“ýük göteriji” diýilýär) we Ether bolup biler.

Maksatly hasapda kod bar bolsa, bu kod işleýär we netijede ýük göteriji giriş hökmünde kabul edilýär.

Maksatly hasap görkezilmedik bolsa (geleşigiň alyjysy ýok ýa-da alyjynyň güýji ýok bolsa), geleşik täze şertnama döretmek üçin niýetlenendir. Öň bellenip geçilişi ýaly, bu şertnamanyň salgysy nol salgy däl-de, iberijiden alnan salgy we iberilen amallaryň sany (“null”). Şeýle şertnamany döretmek üçin “EVM” kod kody hökmünde kabul edilýär we ýerine ýetirilýär. Bu programmanyň çykyş maglumatlary şertnamanyň kody hökmünde hemişelik saklanýar. Şeýlelik bilen şertnama döretmek üçin şertnamanyň hakyky koduny ibermezlik, bu kod ýerine ýetirilende ýüze çykarylan maglumatlary ibermegi aňladýar.

### Gaz

Her bir islenýän geleşik, geleşigi ýerine ýetirmek üçin zerur iş mukdaryny çäklendirmek we şol bir wagtyň özünde bu amal üçin zerur tölegi almak üçin belli bir mukdarda gaz alynýar. EVM amalyny ýerine ýetireniňizde, gaz belli bir düzgünlere görä kem-kemden üýtgeýär.

Gaz tölegi, geleşigi esaslandyryjynyň iberijiniň hasabyndan `gaz_fee * gaz` mukdarynda tölemeli bahasydyr. Programmadan soň käbir gaz galan bolsa, galan gaz mukdaryna gabat gelýän efir şol bir usul bilen iberijiniň hasabyna gaýtarylýar.


### Saklamak we ýatlamak

Ethereum wirtual maşyn (EVM) indiki abzaslarda düşündirilişi ýaly saklamak, ýat we üýşmek ýaly üç dürli ugurda maglumatlary saklaýar.

Her bir hasapda funksiýa jaňlary we amallary arasynda dowam edýän ammar diýilýän maglumat meýdany bar. Ammarda 256 bitli sözleri 256 bitli sözlere kartalaşdyrýan açar baha jübüti bar. Şertnamanyň çäginde ammarlary kesgitlemek mümkin däl. Saklamak gaty gymmat amal, çalyşmak has köp çykdajy edip biler. Şertnama özünden başga ammarlary okap ýa-da päsgel berip bilmez.

Ikinji maglumat meýdany, her täze geleşik jaňy bilen şertnamanyň yzyna gaýtaryp berýän ýady ýa-da ýady diýýän zadymyzdyr. Oryat çyzykly we baýt derejesinde çözülip bilner, ýöne ýazgylar 8 bit ýa-da 256 bit bolup biler, okalýan bolsa 256 bit bilen çäklenýär. Öň degilmedik ýat meýdanyna gireniňizde (okaň ýa-da ýazyň), bu meýdany (256 bit) ýazylan ýerinden (8 bit) giňeldip bolýar. Bu giňeliş wagtynda ýüze çykyp biljek goşmaça gaz bahasy iberiji tarapyndan tölenmeli. Memoryat näçe uly bolsa, çykdajy şonça-da köpeler (artmak mukdaryň kwadraty bolar).

EVM hasaba alyş maşynyna garanyňda has köp maşyn, şonuň üçin ähli hasaplamalar stack diýilýän maglumat meýdanynda ýerine ýetirilýär. Bu meýdan iň ýokary kuwwatlylygy 1024 element bolup, 256 bitli maglumatlary öz içine alýar. Stakanyň girişi ýokarky ujy bilen aşakdaky ýaly çäklendirilýär: Iň oňat 16 elementiň birini stakanyň ýokarsyna göçürip ýa-da ýokarky elementi aşakdaky 16 elementiň biri bilen çalşyp bolýar. Otherhli beýleki amallar iň ýokarky iki (ýa-da bir ýa-da birnäçe) elementi stakadan alýar we netijäni staka iterýär. Elbetde, stakanyň çuňlugyna ýetmek üçin stak elementlerini saklamaga ýa-da ýada geçirip bolýar, ýöne stakanyň ýokarsyny aýyrman has çuňňur girip bolmaýar.

### Görkezme toplumy

EVM-iň görkezmeler toplumy ylalaşyk meselelerine sebäp bolup biljek nädogry ýa-da gabat gelmeýän amallardan gaça durmak üçin iň az derejede saklanýar. Instructionshli görkezmeler esasy maglumat görnüşinde, 256 bit sözde ýa-da ýat böleklerinde (ýa-da beýleki baýt massiwlerinde) işleýär. Adaty arifmetiki, bitwise, logiki we deňeşdirme amallary bar. Şertli we şertsiz bökmek mümkindir. Mundan başga-da, şertnamalarda häzirki blokyň sany we wagt belgisi ýaly degişli häsiýetlere hem girip bolýar.

### Habar jaňlary

Şertnamalar beýleki şertnamalara jaň edip ýa-da Ether habar jaňy arkaly şertnama däl hasaplara iberip biler. Habar jaňlary, çeşmesi, barjak ýeri, ýük göterijisi, Ether, gaz we gaýdyp beriş maglumatlary bolan amallara meňzeýär. Bu logika laýyklykda görlen her bir amal, ýokary derejeli habar jaňlaryndan ybarat bolup, öz gezeginde has köp jaň döredip biler.

Galan gazyň näçesini içerki habar jaňy arkaly ibermelidigini we ýük daşamak wagtynda näçeräk sarp ediljekdigini şertnama kesgitläp biler. Içerki jaňda gazdan daşary kadadan çykma (ýa-da başga bir kadadan çykma) ýüze çyksa, staka goşulan säwlik bahasy bilen habar berilýär. Bu ýagdaýda diňe jaň bilen iberilen gaz sarp edilýär. “Solidity” dilinde şeýle kadadan çykmalaryň ýüze çykmagy, stakany “köpürjikleýän” ýagdaý bilen häsiýetlendirilýär, sebäbi adaty ýagdaýda el bilen zynjyrly kadadan çykmalar döredýär.

Çagyryşlar 1024 bitli meýdan bilen çäklenýär; bu has çylşyrymly amallar üçin gaýtalanýan jaňlardan aýlawlaryň has ileri tutulýandygyny aňladýar. Mundan başga-da, düwürtigiň diňe 63/64 habaryna jaň edip bolýar; bu iş ýüzünde 1000 bitden az giňişlik çäklendirilmegine getirýär.

### Delegatecall / Çağrı Kodu & Kütüphaneler

Esasan habar jaňy bilen birmeňzeş, delegatcall jaň şertnamasynyň çäginde maksat salgysynda kod ýerine ýetirmek we ` msg.sender we msg.value` üýtgetmezlik ýaly aýratyn habar görnüşi hasaplanýar. Bu, şertnamanyň ýerine ýetirilişinde başga bir salgydan dinamiki ýagdaýda kod ýükläp biljekdigini aňladýar. Saklamak, häzirki salgy we balans henizem çagyrylýan şertnama degişlidir, diňe çagyrylan salgydan kod bar.

### Yazgylar

Maglumatlary blokirleme derejesine çenli kartalaşdyrýan adaty indekslenen maglumat gurluşynda saklamak mümkindir. Hasaba alyş diýilýän bu aýratynlyk, kodda agzalan wakalary amala aşyrmak üçin Solidity tarapyndan ulanylýar. Şertnamalar döredilenden soň, hasaba alyş maglumatlary elýeterli däl, ýöne zynjyryň daşyndan täsirli bolýar. Logurnal maglumatlarynyň käbiri gül süzgüçlerinde saklanýandygy sebäpli, bu maglumatlary täsirli we kriptografiki taýdan ygtybarly gözlemek mümkindir, şonuň üçin tor elementleri (“inçe müşderiler” diýlip hem atlandyrylýar) göçürip almazdan bu ýazgylara girip biler. tutuş zynjyr.

### Çagyryş döretmek

Şertnamalar hatda adaty kod koduny ulanyp başga şertnamalar döredip biler (muny maksat salgysyny boş goýup edýärler). Bu jaň jaňlary bilen adaty habar jaňlarynyň arasyndaky ýeke-täk tapawut, açyk ýüküň ýerine ýetirilmegi we netije kod görnüşinde saklanmagydyr, bu ýerde jaň edýän tarap (dörediji) täze şertnamanyň salgysyny alýar.

### Öçürmek we öz-özüňi ýok etmek

Bir zincirden kodu kaldırmanın tek yolu, söz konusu adresteki bir sözleşmenin `selfdestruct` özelliğini aktif hale getirmesidir. Bu adreste kalan Eter belirlenmiş bir önceden belirtilen bir hedefe gönderilir ve ardından depolama ve kod durumdan çıkarılır. Sözleşmeyi teoride çıkarmak iyi bir fikir gibi görünse bile, birileri kaldırılmış sözleşmelere Ether gönderirse, Ether sonsuza dek kaybedilme tehlikesi ile karşı karşıya kalır.







