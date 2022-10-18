# Sample Hardhat Project

```
    Welcome!

    My names are Isaac Jesse. O, a.k.a : some call me Bob, some say Bobelr while others know me as Bobman7000. I am still same person.
```
Kindly visit [my profile page]())

This repository feature projects that demonstrates my skils as a smart contract and web3 developer. Please head over to the contract directory for smart contract projects. I will continuously update the repository from time to time. For enquiries, partnership or job opportunities, please do alert me via **[myEmail](dev.qContrib@gmail.com)** 

From the root:

```
cd contracts/marriageculture

```

### MarriageCulture
This section of the contracts models a real-life scenario, depicts the marriage standard and practices that are common to the Nigerians especially Igbos and the Yorubas. The contract doesn't really do much but to explain in code how the process of marriage should go. 

`Note`: It might not fully explain all of the concepts or how you expect it but just for fun, I created that.

### Structure
- contracts:
    - marriageculture:
        - interfaces:
            - Common.sol: Contains user-defined data types that are required/use by more than one file

            - IHusband.sol: Application Programming Interface for the `Husband`.

            - Inlaw.sol: Declares how to interact with the `Inlaw`.

            - IWife.sol: Declares how to interact with `WifeToBe`.

        - wealth:
            - CashInBank.sol: Husband's cash base/bank.
            `Note `: An implementation of the ERC20 Fungible Asset.

            - Properties.sol: The amount of properties he own. 
            `Note `: It's an implementation of the ERC721 Non-Fungible Asset i.e NFT.

        - Husband.sol: Interface implemented by Husband.sol. With this, `Inlaw.sol` and `Wife.sol` are able to interact with the husband.

            - payDowry
            - tryPropose
            - tryCopulate
            - spendMoney
            - isMarried
            - profile
            - inlaw

        - Inlaw.sol: Implements the `IInlaw.sol`. Husband interacts with the inlaw via the the `IInlaw`.

            - getBridePrize
            - bank
            - spendMoney
            - getMarriageApproval
            - 

        - Wife.sol: Implements the `IWifeToBe.sol`. Husband and parent/inlaw interact with the wife through the `IWifeToBe.sol`.

            - tryPropose
            - setMarriageStatus
            - checkStatus
            - tryCopulate

<!-- a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
``` -->
