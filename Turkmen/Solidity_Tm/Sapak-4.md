# <div align="center">Solidity in depth</div>

## Solidity çeşmesi faýlynyň gurluşy

Resource faýyllarynda özbaşdak şertnama kesgitlemeleri, <em>import we pragma</em> görkezmeleri bolup biler.

## Pragmalar

`Pragma` açar sözi, düzüjiniň aýratynlyklaryny ýa-da dolandyryşlaryny işletmek üçin ulanylýar. Pragma görkezmesi elmydama çeşme faýly üçin ýerli bolup durýar, şonuň üçin pragmany ähli taslamaňyza işletmek isleseňiz, ähli faýllaryňyza goşmaly. Başga bir faýl import etseňiz, şol faýldaky pragma import edilen faýla awtomatiki ulanylmaýar.

### Pragma Version

Resource faýyllary pragma wersiýasyna, gabat gelmeýän üýtgeşmeleri girizip biljek ýa-da faýlyň işlemeginiň öňüni alyp biljek täze düzüjiler wersiýalaryna duş gelende çeşme faýyllarynyň bozulmazlygy üçin koduň başynda aýan edilmelidir. Şeýlelik bilen, täze pragma wersiýalary bilen geljekdäki üýtgeşmeleri iň pes derejede saklamaga synanyşýarys we sintaksisde üýtgeşmeler girizip semantik üýtgeşmeleri sazlamaga synanyşýarys, ýöne elbetde bu hemişe mümkin däl. Esasanam `0.x.0` we `x.0.0` formada peýda bolan we uly üýtgeşmeleri öz içine alýan wersiýalar üçin üýtgeşmeler sanawyny gözden geçirmegiň zerurdygyny ýatladýarys.

Pragma version şu şekilde:

```
pragma solidity ^0.5.2;
```

