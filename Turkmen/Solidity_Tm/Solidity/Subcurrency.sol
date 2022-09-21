// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract Coin {
    // "public" anahtar kelimesi değişkenler yapar.
    // diğer sözleşmelerden erişilebilir
    address public minter;
    mapping (address => uint) public balances;

    // Events, müşterilerin ayrıntılara tepki vermesini sağlar
    // beyan ettiğiniz sözleşme değişiklikleri
    event Sent(address from, address to, uint amount);

    // Yapıcı kodu yalnızca sözleşme yapıldığında çalıştırılır.
    // ve oluşturulur
    constructor() {
        minter = msg.sender;
    }

    // Bir adrese yeni oluşturulan bir miktar para gönderir
    // Yalnızca sözleşmeyi oluşturan kişi tarafından çağrılabilir
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    // Hatalar hakkında bilgi vermenizi sağlar
    // neden bir işlem başarısız oldu. iade edildiler
    // fonksiyonun arayanına.
    error InsufficientBalance ( uint requested, uint available);

    // Mevcut bir miktar para gönderir
    // herhangi bir arayandan bir adrese
    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}