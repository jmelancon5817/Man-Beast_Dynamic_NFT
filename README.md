# Chainlink_Keepers_Dynamic_NFT

<h2>Project Description</h2>
A dynamic NFT contract using <a href="https://docs.chain.link/docs/chainlink-keepers/introduction/">Chainlink Keepers</a> to automate "morphing" the NFT between two forms (Man & Beast) on a set time interval.

<img alt="Day-Walker" width="40px" src="images/image.PNG" />
<img alt="Were-Dog" width="40px" src="images/image.PNG" />
<h2>Process</h2>
I first created two images that I could use to represent each form of the NFT.  Then I uploaded the images to IPFS, along with jsons for each form.
After altering the contract to fit my idea I deployed to the Rinkeby test network via the Remix IDE connected to my Metamask wallet.
I was able to aquire Rinkeby LINK/ETH from the <a href="https://faucets.chain.link/rinkeby">chainlink faucet</a>.
Once the contract was deployed, and I had minted a token to my address, I then registered my contract with chainlink keepers for upkeep.
With the keeper contract funded with Link and the time interval up I verified the morphing of the NFT from one form to the next via the tokenUri() method.
I was also able to look up my contract address on the <a href="https://testnets.opensea.io">OpenSea Testnets</a> and witness the NFT change forms.
For my project the NFT was set to morph back and forth from "Man" to "Beast" every 12 hours.
<h2>Acknowledgements</h2>
This project was completed as part of a chainlink <a href ="https://www.youtube.com/watch?v=E7Rm1LUKhj4">instructional video</a> presented by Richard Gottleber.

Creative inspiration was provided by the 1985 american horror film <a href="https://en.wikipedia.org/wiki/Silver_Bullet_(film)">Silver Bullet</a>, staring Corey Haim and Gary Busey.
<h2>Find Me</h2>
Twitter: https://twitter.com/melancon_jake
