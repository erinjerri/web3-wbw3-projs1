// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// create initial contract class, definte struct properties  
contract Web3RSVP {
    struct CreateEvent {
        bytes32 eventId;
        string eventDataCID;
        address eventOwner;
        uint256 eventTimestamp;
        uint256 deposit;
        uint256 maxCapacity;
        address[] confirmedRSVPs;
        address[] claimedRSVPs;
        bool paidOut;
   }
   mapping(bytes32 => CreateEvent) public idToEvent;
   // define mapping of eventID to struct

// define functions and what it handles (tracking event RSVPs), limitation of event attendees etc.
   function createNewEvent(
    uint256 eventTimestamp,
    uint256 deposit,
    uint256 maxCapacity,
    string calldata eventDataCID
) external {
    // generate an eventID based on other things passed in to generate a hash - decrease collision resistance
    bytes32 eventId = keccak256(
        abi.encodePacked(
            msg.sender,
            address(this),
            eventTimestamp,
            deposit,
            maxCapacity
        )
    );

    address[] memory confirmedRSVPs;
    address[] memory claimedRSVPs;
    // define array users who RSVP vs those who actually come to an event or claim RSVP 

    // this creates a new CreateEvent struct and adds it to the idToEvent mapping
    // the key is the eventID and the value is the struct with properties grabbed from function arguments passed by the user, or some that we generate internally.
    // false defines if there are no RSVPs.
    idToEvent[eventId] = CreateEvent(
        eventId,
        eventDataCID,
        msg.sender,
        eventTimestamp,
        deposit,
        maxCapacity,
        confirmedRSVPs,
        claimedRSVPs,
        false
    );
}
}
