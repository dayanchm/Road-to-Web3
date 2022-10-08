# <div align="center">Solidity Mysallary</div>

## Ses bermek

Aşakdaky şertnama gaty çylşyrymly, ýöne size “Solidity” -iň köp aýratynlyklaryny gözden geçirmäge mümkinçilik berýär. Aşakda ses berişlik şertnamasy bar. Elektron ses berişlikde ýüze çykan esasy meseleler; dogry adamlara nädip ses bermek hukugyny bermeli we manipulýasiýanyň öňüni almaly. Bu meseleleriň hemmesini aşakdaky konwensiýa bilen çözüp bilmeris, ýöne iň bolmanda sesleriň sanalmagynyň bir wagtda, awtomatiki we doly aç-açan bolup biljekdigi üçin wekilçilikli ses berişligiň nädip edilip bilinjekdigini görkezeris.

Maksat, her bir ses beriji üçin bir şertnama we her şertnama üçin gysga at döretmekden ybarat. Şertnamany dörediji, soňra başlyk wezipesini ýerine ýetirýän bolsa, her adrese aýratyn ses bermek hukugyny berer.

Salgylaryň aňyrsynda duran adamlar özlerine ses berip bilerler ýa-da ses berişlikde seslerini ynamdar birine berip bilerler.

Ses berişlik möhletiniň ahyrynda winningProposal() funksiýasy iň köp ses kesgitlär we bu adam ses alar.

```
pragma solidity >=0.4.22 <0.6.0;

/// @title Voting with delegation.

contract Ballot {
    // This declares a new complex type which will
    // be used for variables later.
    // It will represent a single voter.
    struct Voter {
        uint weight; // weight is accumulated by delegation
        bool voted;  // if true, that person already voted
        address delegate; // person delegated to
        uint vote;   // index of the voted proposal
    }

    // This is a type for a single proposal.
    struct Proposal {
        bytes32 name;   // short name (up to 32 bytes)
        uint voteCount; // number of accumulated votes
    }

    address public chairperson;

    // This declares a state variable that
    // stores a `Voter` struct for each possible address.
    mapping(address => Voter) public voters;

    // A dynamically-sized array of `Proposal` structs.
    Proposal[] public proposals;

    /// Create a new ballot to choose one of `proposalNames`.
    constructor(bytes32[] memory proposalNames) public {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        // For each of the provided proposal names,
        // create a new proposal object and add it
        // to the end of the array.
        for (uint i = 0; i < proposalNames.length; i++) {
            // `Proposal({...})` creates a temporary
            // Proposal object and `proposals.push(...)`
            // appends it to the end of `proposals`.
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // Give `voter` the right to vote on this ballot.
    // May only be called by `chairperson`.
    function giveRightToVote(address voter) public {
        // If the first argument of `require` evaluates
        // to `false`, execution terminates and all
        // changes to the state and to Ether balances
        // are reverted.
        // This used to consume all gas in old EVM versions, but
        // not anymore.
        // It is often a good idea to use `require` to check if
        // functions are called correctly.
        // As a second argument, you can also provide an
        // explanation about what went wrong.
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

    /// Delegate your vote to the voter `to`.
    function delegate(address to) public {
        // assigns reference
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You already voted.");

        require(to != msg.sender, "Self-delegation is disallowed.");

        // Forward the delegation as long as
        // `to` also delegated.
        // In general, such loops are very dangerous,
        // because if they run too long, they might
        // need more gas than is available in a block.
        // In this case, the delegation will not be executed,
        // but in other situations, such loops might
        // cause a contract to get "stuck" completely.
        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            // We found a loop in the delegation, not allowed.
            require(to != msg.sender, "Found loop in delegation.");
        }

        // Since `sender` is a reference, this
        // modifies `voters[msg.sender].voted`
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];
        if (delegate_.voted) {
            // If the delegate already voted,
            // directly add to the number of votes
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            // If the delegate did not vote yet,
            // add to her weight.
            delegate_.weight += sender.weight;
        }
    }

    /// Give your vote (including votes delegated to you)
    /// to proposal `proposals[proposal].name`.
    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = proposal;

        // If `proposal` is out of the range of the array,
        // this will throw automatically and revert all
        // changes.
        proposals[proposal].voteCount += sender.weight;
    }

    /// @dev Computes the winning proposal taking all
    /// previous votes into account.
    function winningProposal() public view
            returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    // Calls winningProposal() function to get the index
    // of the winner contained in the proposals array and then
    // returns the name of the winner
    function winnerName() public view
            returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}
```
## Goragly auksion

Bu bölümde, Ethereum-da doly şahsy auksion şertnamasyny döretmegiň nähili aňsatdygyny size görkezeris. Hususy däl auksiondan başlarys, bu ýerde teklipleriň hemmesini görüp bileris, soň bolsa şertnamany hususy auksiona öwüreris, bu ýerde söwda möhleti gutarýança hakyky teklibi görüp bolmaz.


## Goragsyz auksion

Aşakdaky ýönekeý we gizlin däl auksion şertnamasynyň umumy pikiri, söwda prosesinde her kim aç-açan teklip edip biler. Dalaşgärler öz tekliplerine söz beren pullary / Ether bilen baglanyşýarlar. Iň ýokary teklip başga biriniň teklibinden ýokary bolsa, köne iň ýokary teklip ýatyrylýar. Söwda möhleti gutarandan soň, hakyky gatnaşyjy we satyjy şertnamany el bilen tassyklaýarlar, önümleriň ýa-da hyzmatlaryň alyş-çalşyny tamamlaýarlar - şertnamalar bu amal bolmazdan işjeň bolup bilmez.

```
pragma solidity >=0.4.22 <0.6.0;

contract SimpleAuction {
    // Parameters of the auction. Times are either
    // absolute unix timestamps (seconds since 1970-01-01)
    // or time periods in seconds.
    address payable public beneficiary;
    uint public auctionEndTime;

    // Current state of the auction.
    address public highestBidder;
    uint public highestBid;

    // Allowed withdrawals of previous bids
    mapping(address => uint) pendingReturns;

    // Set to true at the end, disallows any change.
    // By default initialized to `false`.
    bool ended;

    // Events that will be emitted on changes.
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    // The following is a so-called natspec comment,
    // recognizable by the three slashes.
    // It will be shown when the user is asked to
    // confirm a transaction.

    /// Create a simple auction with `_biddingTime`
    /// seconds bidding time on behalf of the
    /// beneficiary address `_beneficiary`.
    constructor(
        uint _biddingTime,
        address payable _beneficiary
    ) public {
        beneficiary = _beneficiary;
        auctionEndTime = now + _biddingTime;
    }

    /// Bid on the auction with the value sent
    /// together with this transaction.
    /// The value will only be refunded if the
    /// auction is not won.
    function bid() public payable {
        // No arguments are necessary, all
        // information is already part of
        // the transaction. The keyword payable
        // is required for the function to
        // be able to receive Ether.

        // Revert the call if the bidding
        // period is over.
        require(
            now <= auctionEndTime,
            "Auction already ended."
        );

        // If the bid is not higher, send the
        // money back.
        require(
            msg.value > highestBid,
            "There already is a higher bid."
        );

        if (highestBid != 0) {
            // Sending back the money by simply using
            // highestBidder.send(highestBid) is a security risk
            // because it could execute an untrusted contract.
            // It is always safer to let the recipients
            // withdraw their money themselves.
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }

    /// Withdraw a bid that was overbid.
    function withdraw() public returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // It is important to set this to zero because the recipient
            // can call this function again as part of the receiving call
            // before `send` returns.
            pendingReturns[msg.sender] = 0;

            if (!msg.sender.send(amount)) {
                // No need to call throw here, just reset the amount owing
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    /// End the auction and send the highest bid
    /// to the beneficiary.
    function auctionEnd() public {
        // It is a good guideline to structure functions that interact
        // with other contracts (i.e. they call functions or send Ether)
        // into three phases:
        // 1. checking conditions
        // 2. performing actions (potentially changing conditions)
        // 3. interacting with other contracts
        // If these phases are mixed up, the other contract could call
        // back into the current contract and modify the state or cause
        // effects (ether payout) to be performed multiple times.
        // If functions called internally include interaction with external
        // contracts, they also have to be considered interaction with
        // external contracts.

        // 1. Conditions
        require(now >= auctionEndTime, "Auction not yet ended.");
        require(!ended, "auctionEnd has already been called.");

        // 2. Effects
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);

        // 3. Interaction
        beneficiary.transfer(highestBid);
    }
}

```

## Goragly auksion 

Aşakdaky ýaly gizlin auksion şertnamasyny almak üçin öňki auksion şertnamasyna goşalyň. Gizlin auksionyň artykmaçlygy, söwda möhletiniň gutarmagyna wagt basyşynyň bolmazlygydyr. “Blockchain” ýaly aç-açan söwda platformasynda hususy auksion gurmak gapma-garşy bolup görünýär; emma kriptografiýa bu ýagdaýda bize kömek edýär.

Söwda prosesinde, gatnaşyjy aslynda öz teklibini tabşyrmaýar, teklip kodlanan görnüşde iberilýär. Iki uzyn teklibiň şifrlenen mahaly deň bahasy bolmagy mümkin däl diýen ýaly, gatnaşyjylar üçin hiç hili mesele ýok. Söwda möhleti gutarandan soň, gatnaşyjylardan öz tekliplerini düşündirmegi haýyş edilýär: Şifrlenmedik teklipleriň bu ýerde yglan eden bahalary bilen deňdigini ýa-da ýokdugyny barlaýan şertnamanyň kömegi bilen, iň ýokary teklip alan gatnaşyjy bu bäsleşigi ýeňýär. .

Iseüze çykyp biläýjek bir mesele, söwdany gatnaşyjy üçin gizlin auksionda şol bir wagtyň özünde hökmany we gizlin etmekdir: auksionda ýeňiji bolandan soň pul ibermeginiň öňüni almagyň ýeke-täk usuly, şol pursatda ondan almakdyr. teklip edýär. Pul geçirimlerini Ethereumda gizläp bolmaýandygy sebäpli, iberilen bahany her kim görüp biler.

Aşakdaky konwensiýa, iň ýokary teklipden has uly bahany kabul etmek bilen bu meseläni çözýär. Elbetde, bu käbir teklipleriň bilkastlaýyn nädogry iberilmegine sebäp bolup biler, sebäbi bu diňe teklipler aýan edilende barlanyp bilner. Şeýlelik bilen, gatnaşyjylar gaty ýokary ýa-da gaty pes bolan birnäçe nädogry teklipler bilen bäsleşigi güýçlendirip bilerler.
```
pragma solidity >0.4.23 <0.6.0;

contract BlindAuction {
    struct Bid {
        bytes32 blindedBid;
        uint deposit;
    }

    address payable public beneficiary;
    uint public biddingEnd;
    uint public revealEnd;
    bool public ended;

    mapping(address => Bid[]) public bids;

    address public highestBidder;
    uint public highestBid;

    // Allowed withdrawals of previous bids
    mapping(address => uint) pendingReturns;

    event AuctionEnded(address winner, uint highestBid);

    /// Modifiers are a convenient way to validate inputs to
    /// functions. `onlyBefore` is applied to `bid` below:
    /// The new function body is the modifier's body where
    /// `_` is replaced by the old function body.
    modifier onlyBefore(uint _time) { require(now < _time); _; }
    modifier onlyAfter(uint _time) { require(now > _time); _; }

    constructor(
        uint _biddingTime,
        uint _revealTime,
        address payable _beneficiary
    ) public {
        beneficiary = _beneficiary;
        biddingEnd = now + _biddingTime;
        revealEnd = biddingEnd + _revealTime;
    }

    /// Place a blinded bid with `_blindedBid` =
    /// keccak256(abi.encodePacked(value, fake, secret)).
    /// The sent ether is only refunded if the bid is correctly
    /// revealed in the revealing phase. The bid is valid if the
    /// ether sent together with the bid is at least "value" and
    /// "fake" is not true. Setting "fake" to true and sending
    /// not the exact amount are ways to hide the real bid but
    /// still make the required deposit. The same address can
    /// place multiple bids.
    function bid(bytes32 _blindedBid)
        public
        payable
        onlyBefore(biddingEnd)
    {
        bids[msg.sender].push(Bid({
            blindedBid: _blindedBid,
            deposit: msg.value
        }));
    }

    /// Reveal your blinded bids. You will get a refund for all
    /// correctly blinded invalid bids and for all bids except for
    /// the totally highest.
    function reveal(
        uint[] memory _values,
        bool[] memory _fake,
        bytes32[] memory _secret
    )
        public
        onlyAfter(biddingEnd)
        onlyBefore(revealEnd)
    {
        uint length = bids[msg.sender].length;
        require(_values.length == length);
        require(_fake.length == length);
        require(_secret.length == length);

        uint refund;
        for (uint i = 0; i < length; i++) {
            Bid storage bidToCheck = bids[msg.sender][i];
            (uint value, bool fake, bytes32 secret) =
                    (_values[i], _fake[i], _secret[i]);
            if (bidToCheck.blindedBid != keccak256(abi.encodePacked(value, fake, secret))) {
                // Bid was not actually revealed.
                // Do not refund deposit.
                continue;
            }
            refund += bidToCheck.deposit;
            if (!fake && bidToCheck.deposit >= value) {
                if (placeBid(msg.sender, value))
                    refund -= value;
            }
            // Make it impossible for the sender to re-claim
            // the same deposit.
            bidToCheck.blindedBid = bytes32(0);
        }
        msg.sender.transfer(refund);
    }

    // This is an "internal" function which means that it
    // can only be called from the contract itself (or from
    // derived contracts).
    function placeBid(address bidder, uint value) internal
            returns (bool success)
    {
        if (value <= highestBid) {
            return false;
        }
        if (highestBidder != address(0)) {
            // Refund the previously highest bidder.
            pendingReturns[highestBidder] += highestBid;
        }
        highestBid = value;
        highestBidder = bidder;
        return true;
    }

    /// Withdraw a bid that was overbid.
    function withdraw() public {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // It is important to set this to zero because the recipient
            // can call this function again as part of the receiving call
            // before `transfer` returns (see the remark above about
            // conditions -> effects -> interaction).
            pendingReturns[msg.sender] = 0;

            msg.sender.transfer(amount);
        }
    }

    /// End the auction and send the highest bid
    /// to the beneficiary.
    function auctionEnd()
        public
        onlyAfter(revealEnd)
    {
        require(!ended);
        emit AuctionEnded(highestBidder, highestBid);
        ended = true;
        beneficiary.transfer(highestBid);
    }
}
```
## Ynamly Uzakdan satyn almak

```
pragma solidity >=0.4.22 <0.6.0;

contract Purchase {
    uint public value;
    address payable public seller;
    address payable public buyer;
    enum State { Created, Locked, Inactive }
    State public state;

    // Ensure that `msg.value` is an even number.
    // Division will truncate if it is an odd number.
    // Check via multiplication that it wasn't an odd number.
    constructor() public payable {
        seller = msg.sender;
        value = msg.value / 2;
        require((2 * value) == msg.value, "Value has to be even.");
    }

    modifier condition(bool _condition) {
        require(_condition);
        _;
    }

    modifier onlyBuyer() {
        require(
            msg.sender == buyer,
            "Only buyer can call this."
        );
        _;
    }

    modifier onlySeller() {
        require(
            msg.sender == seller,
            "Only seller can call this."
        );
        _;
    }

    modifier inState(State _state) {
        require(
            state == _state,
            "Invalid state."
        );
        _;
    }

    event Aborted();
    event PurchaseConfirmed();
    event ItemReceived();

    /// Abort the purchase and reclaim the ether.
    /// Can only be called by the seller before
    /// the contract is locked.
    function abort()
        public
        onlySeller
        inState(State.Created)
    {
        emit Aborted();
        state = State.Inactive;
        seller.transfer(address(this).balance);
    }

    /// Confirm the purchase as buyer.
    /// Transaction has to include `2 * value` ether.
    /// The ether will be locked until confirmReceived
    /// is called.
    function confirmPurchase()
        public
        inState(State.Created)
        condition(msg.value == (2 * value))
        payable
    {
        emit PurchaseConfirmed();
        buyer = msg.sender;
        state = State.Locked;
    }

    /// Confirm that you (the buyer) received the item.
    /// This will release the locked ether.
    function confirmReceived()
        public
        onlyBuyer
        inState(State.Locked)
    {
        emit ItemReceived();
        // It is important to change the state first because
        // otherwise, the contracts called using `send` below
        // can call in again here.
        state = State.Inactive;

        // NOTE: This actually allows both the buyer and the seller to
        // block the refund - the withdraw pattern should be used.

        buyer.transfer(value);
        seller.transfer(address(this).balance);
    }
}

```

## Mikro töleg kanaly

Bu bölümde töleg kanalyny durmuşa geçirmegiň mysalyny nädip gurmalydygyny öwreneris. Şol bir taraplaryň arasynda Ether-i yzygiderli geçirmegi ygtybarly, dessine we amal tölegleri bolmazdan kriptografiki gollary ulanýar. Mysal üçin, gollara nädip gol çekmelidigine we barlanmalydygyna düşünmeli we töleg kanalyny gurmaly.

Bu bölümde töleg kanalynyň nusgasyny nädip ösdürmelidigini öwreneris. Şol bir taraplaryň arasynda gaýtalanýan Ether geçirimlerini ygtybarly, çalt we amal tölegleri bolmazdan kriptografiki gollary ulanýar. Mysal üçin, goly nädip döretmelidigine we barlanmalydygyna we töleg kanalyny nädip gurmalydygyna düşünmeli.

### Gollary döretmek we barlamak

Alisiň Bob-a Ether ibermek isleýändigini göz öňüne getiriň, şonuň üçin Alisa iberiji, Bob bolsa kabul ediji.

Alisa kriptografiki taýdan gol çekilen habarlary zynjyrdan (mysal üçin, e-poçta arkaly) Bob-a ibermeli, bu bolsa çek ýazmak ýaly bir zat.

Alisa we Bob öz gollaryny Ethereum bilen akylly şertnamadaky amallary tassyklamak üçin ulanýarlar. Bu ýerde Alisa oňa Etheri geçirmäge mümkinçilik berýän ýönekeý akylly şertnama döredýär, ýöne töleg başlamak üçin şol şertnamadan bir funksiýa çagyrmagyň ýerine, Bob muny edip biler we şeýlelik bilen amal tölegini töläp biler.

Şertnama aşakdaky ýaly işleyär:

1.Alisa, tölenmeli tölegleri ýapmak üçin ýeterlik Ether goşup, `ReceiverPays` şe
