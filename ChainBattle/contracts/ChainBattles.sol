// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainBattles is ERC721URIStorage  {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => uint256) public tokenIdToLevels;

    constructor() ERC721 ("Chain Battles", "CBTLS"){
    }

function generateCharacter(uint256 tokenId) public returns(string memory){

    bytes memory svg = abi.encodePacked(
        '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 300 180">',
        '<style type="text/css"> .base { font-family: microsoft yahei;} .warrior { fill: black; font-size: 28px; font-weight: bolder; } .level { fill: red; font-size: 20px; font-style: italic;} </style>',
        '<svg>',
        '<path fill="#880404" stroke="#880404" d="M 67.27 9.96 C 69.68 10.31 72.40 11.37 72.84 14.09 C 72.49 16.74 71.18 19.21 71.21 21.92 C 71.29 26.66 72.54 31.54 71.04 36.18 C 67.78 39.66 64.78 43.96 65.16 48.98 C 65.08 53.97 69.43 57.55 73.69 59.25 C 79.34 61.37 85.43 61.84 91.36 62.67 C 84.43 63.42 76.73 64.62 70.53 60.57 C 66.92 58.64 65.22 54.77 63.67 51.20 C 61.51 45.86 57.05 41.91 52.52 38.58 C 50.73 37.18 48.38 37.16 46.23 37.34 C 40.86 37.76 35.61 39.30 30.79 41.66 C 23.40 44.90 17.69 51.25 14.71 58.68 C 10.87 68.12 10.52 78.59 11.55 88.61 C 12.65 99.17 17.25 109.06 23.16 117.76 C 23.48 119.26 23.74 120.77 24.05 122.27 C 11.71 106.67 6.98 85.45 10.98 66.00 C 12.82 57.55 16.95 49.24 23.98 43.95 C 31.60 37.99 41.52 35.62 51.07 36.01 C 56.21 36.14 61.21 37.63 66.36 37.60 C 67.34 34.14 68.36 30.57 67.86 26.93 C 67.29 21.30 64.31 15.43 67.27 9.96 Z"  />',
        '<path fill="#7ea820" stroke="#7ea820" d="M 71.04 36.18 C 78.61 31.93 87.80 31.75 96.06 33.82 C 103.03 35.66 109.81 38.91 114.92 44.08 C 122.75 51.73 125.70 63.66 123.25 74.21 C 123.00 76.02 121.48 77.13 120.21 78.25 C 119.96 77.91 119.44 77.21 119.18 76.86 C 115.93 72.01 111.89 67.40 106.13 65.58 C 101.47 63.56 96.37 63.02 91.36 62.67 C 85.43 61.84 79.34 61.37 73.69 59.25 C 69.43 57.55 65.08 53.97 65.16 48.98 C 64.78 43.96 67.78 39.66 71.04 36.18 M 67.99 41.97 C 67.71 42.61 67.43 43.26 67.20 43.92 C 66.27 48.47 67.06 53.96 71.50 56.40 C 82.21 62.44 95.13 59.37 106.45 63.42 C 111.48 64.79 115.23 68.53 119.08 71.81 L 119.41 72.39 C 120.33 72.43 121.25 72.49 122.17 72.56 C 121.79 66.02 116.68 61.10 112.00 57.09 C 109.29 55.10 106.88 52.34 103.40 51.80 C 101.37 50.52 99.91 48.41 97.66 47.43 C 90.76 43.96 83.28 41.55 75.65 40.40 C 72.90 39.73 70.69 42.05 67.99 41.97 Z"  />',
        '<path fill="#aa0001" stroke="#aa0001" d="M 30.79 41.66 C 35.61 39.30 40.86 37.76 46.23 37.34 C 48.38 37.16 50.73 37.18 52.52 38.58 C 57.05 41.91 61.51 45.86 63.67 51.20 C 65.22 54.77 66.92 58.64 70.53 60.57 C 76.73 64.62 84.43 63.42 91.36 62.67 C 96.37 63.02 101.47 63.56 106.13 65.58 C 109.04 68.06 111.95 70.62 114.25 73.70 C 117.31 77.79 116.87 83.22 116.76 88.04 C 116.65 95.39 113.36 102.11 111.99 109.24 C 110.74 114.02 107.73 118.06 105.15 122.20 C 100.87 128.28 96.29 134.89 89.35 138.12 C 84.67 139.42 79.91 140.95 75.00 140.70 C 71.00 140.53 67.03 139.75 63.02 139.91 C 57.85 140.01 52.60 141.51 47.47 140.18 C 44.16 139.33 40.94 138.15 37.70 137.03 C 34.21 135.54 31.75 132.48 29.20 129.79 C 27.27 127.46 24.98 125.21 24.05 122.27 C 23.74 120.77 23.48 119.26 23.16 117.76 C 29.04 124.57 35.27 131.64 43.73 135.23 C 47.52 136.88 51.52 134.79 54.60 132.61 C 61.46 127.60 68.17 121.98 72.53 114.56 C 77.28 106.65 81.21 97.49 79.83 88.06 C 78.84 80.64 73.84 74.24 67.37 70.67 C 63.86 68.32 59.01 66.75 57.56 62.37 C 56.76 58.07 57.65 53.68 57.85 49.36 C 53.45 46.28 48.59 43.76 43.24 42.90 C 42.78 42.85 41.85 42.74 41.39 42.68 C 37.86 42.29 34.33 41.83 30.79 41.66 Z"  />',
        '<path fill="#badf20" stroke="#badf20" d="M 67.99 41.97 C 70.69 42.05 72.90 39.73 75.65 40.40 C 83.28 41.55 90.76 43.96 97.66 47.43 C 99.91 48.41 101.37 50.52 103.40 51.80 C 106.88 52.34 109.29 55.10 112.00 57.09 C 116.68 61.10 121.79 66.02 122.17 72.56 C 121.25 72.49 120.33 72.43 119.41 72.39 L 119.08 71.81 C 115.14 63.05 105.37 59.42 96.40 58.65 C 95.42 55.72 93.24 53.51 90.75 51.79 C 92.13 54.14 93.65 56.43 95.42 58.52 C 88.07 58.26 80.25 59.04 73.46 55.66 C 69.05 53.54 67.89 48.31 67.20 43.92 C 67.43 43.26 67.71 42.61 67.99 41.97 M 74.19 42.64 C 73.46 44.11 74.05 47.14 75.78 47.48 C 76.39 46.00 75.83 43.07 74.19 42.64 M 86.29 44.50 C 85.68 45.95 87.00 48.66 88.68 48.51 C 89.27 47.06 87.97 44.35 86.29 44.50 Z"  />',
        '<path fill="#d0000e" stroke="#d0000e" d="M 14.71 58.68 C 17.69 51.25 23.40 44.90 30.79 41.66 C 34.33 41.83 37.86 42.29 41.39 42.68 C 37.39 43.57 33.34 44.68 29.86 46.90 C 18.36 54.94 11.87 69.36 13.45 83.32 C 15.59 77.15 16.35 70.45 19.79 64.78 C 25.35 55.45 33.90 48.26 43.24 42.90 C 48.59 43.76 53.45 46.28 57.85 49.36 C 57.65 53.68 56.76 58.07 57.56 62.37 C 59.01 66.75 63.86 68.32 67.37 70.67 C 73.84 74.24 78.84 80.64 79.83 88.06 C 81.21 97.49 77.28 106.65 72.53 114.56 C 68.17 121.98 61.46 127.60 54.60 132.61 C 51.52 134.79 47.52 136.88 43.73 135.23 C 35.27 131.64 29.04 124.57 23.16 117.76 C 17.25 109.06 12.65 99.17 11.55 88.61 C 10.52 78.59 10.87 68.12 14.71 58.68 Z"  />',
        '<path fill="#880404" stroke="#880404" d="M 106.13 65.58 C 111.89 67.40 115.93 72.01 119.18 76.86 C 118.99 87.91 117.96 99.64 111.99 109.24 C 113.36 102.11 116.65 95.39 116.76 88.04 C 116.87 83.22 117.31 77.79 114.25 73.70 C 111.95 70.62 109.04 68.06 106.13 65.58 Z"  />',
        '</svg>',
        '<text x="70%" y="45%" class="base warrior" dominant-baseline="middle" text-anchor="middle">',"APPLE",'</text>',
        '<text x="70%" y="65%" class="base level" dominant-baseline="middle" text-anchor="middle">', "Levels: ",getLevels(tokenId),'</text>',
        '</svg>'
    );
    return string(
        abi.encodePacked(
            "data:image/svg+xml;base64,",
            Base64.encode(svg)
        )    
    );
}
function getLevels(uint256 tokenId) public view returns (string memory) {
    uint256 levels = tokenIdToLevels[tokenId];
    return levels.toString();
}
function getTokenURI(uint256 tokenId) public returns (string memory){
    bytes memory dataURI = abi.encodePacked(
        '{',
            '"name": "Chain Battles #', tokenId.toString(), '",',
            '"description": "Battles on chain",',
            '"image": "', generateCharacter(tokenId), '"',
        '}'
    );
    return string(
        abi.encodePacked(
            "data:application/json;base64,",
            Base64.encode(dataURI)
        )
    );
}
function mint() public {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    _safeMint(msg.sender, newItemId);
    tokenIdToLevels[newItemId] = 0;
    _setTokenURI(newItemId, getTokenURI(newItemId));
}
    function train(uint256 tokenId)public{
        require(_exists(tokenId));
        require(ownerOf(tokenId)==msg.sender,"You must own this token to train it");
        uint256 currentLevel=tokenIdToLevels[tokenId];
        tokenIdToLevels[tokenId]=currentLevel+1;
        _setTokenURI(tokenId,getTokenURI(tokenId));
        }
}