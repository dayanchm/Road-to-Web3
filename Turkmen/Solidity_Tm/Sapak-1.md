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

Constructer funksiýasy,diňe şertnama baglaşylanda kesgitlenýän we soňrak çagyrylyp bilinmeýän aýratyn bir funksiýa. 