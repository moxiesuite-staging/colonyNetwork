pragma solidity ^0.4.8;

import "./IColonyFactory.sol";
import "./IRootColonyResolver.sol";
import "./Colony.sol";


contract ColonyFactory is IColonyFactory {

  modifier onlyRootColony(){
    if(msg.sender != IRootColonyResolver(rootColonyResolverAddress).rootColonyAddress()) { throw; }
    _;
  }

  /// @notice this function registers the address of the RootColonyResolver
  /// @param rootColonyResolverAddress_ the default root colony resolver address
  function registerRootColonyResolver(address rootColonyResolverAddress_)
  onlyOwner
  {
    rootColonyResolverAddress = rootColonyResolverAddress_;
  }

  function createColony(address eternalStorage)
  onlyRootColony
  returns(address)
  {
    return new Colony(rootColonyResolverAddress, eternalStorage);
  }
}
