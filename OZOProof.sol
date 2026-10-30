// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract OZOProof {
    // -------------------------------------------------------------------------
    // Errors
    // -------------------------------------------------------------------------

    error AlreadyRegistered();
    error OrganizationNotRegistered();
    error InvalidOrganizationName();
    error InvalidOrganizationId();
    error OrganizationIdAlreadyUsed();
    error InvalidRegistrationDate();
    error InvalidCertificateId();
    error InvalidCertificateHash();
    error CertificateAlreadyExists();
    error Unauthorized();

    // -------------------------------------------------------------------------
    // Data Models
    // -------------------------------------------------------------------------

    struct Organization {
        bytes32 organizationId;
        string organizationName;
        uint64 onchainRegisteredAt;
        uint64 legalRegistrationDate;
    }

    struct Certificate {
        bytes32 organizationId;
        bytes32 certificateId;
        uint64 issuedAt;
    }

    // owner → organization
    mapping(address => Organization) private organizationsByOwner;

    // organizationId → organization
    mapping(bytes32 => Organization) private organizationsById;

    // certificateHash → certificate
    mapping(bytes32 => Certificate) private certificatesByHash;

    // -------------------------------------------------------------------------
    // Events
    // -------------------------------------------------------------------------

    event OrganizationRegistered(
        address indexed owner,
        bytes32 indexed organizationId,
        string organizationName,
        uint64 legalRegistrationDate,
        uint64 onchainRegisteredAt
    );

    event CertificateIssued(
        bytes32 indexed organizationId,
        bytes32 certificateId,
        bytes32 indexed certificateHash,
        uint64 issuedAt
    );

    // -------------------------------------------------------------------------
    // Register Organization
    // -------------------------------------------------------------------------

    function registerOrganization(
        string calldata organizationName,
        bytes32 organizationId,
        uint64 legalRegistrationDate
    ) external {
        if (organizationsByOwner[msg.sender].organizationId != bytes32(0))
            revert AlreadyRegistered();

        if (bytes(organizationName).length == 0)
            revert InvalidOrganizationName();

        if (organizationId == bytes32(0)) revert InvalidOrganizationId();

        if (organizationsById[organizationId].organizationId != bytes32(0))
            revert OrganizationIdAlreadyUsed();

        if (
            legalRegistrationDate == 0 ||
            legalRegistrationDate > block.timestamp
        ) revert InvalidRegistrationDate();

        uint64 nowTs = uint64(block.timestamp);

        Organization memory org = Organization({
            organizationId: organizationId,
            organizationName: organizationName,
            onchainRegisteredAt: nowTs,
            legalRegistrationDate: legalRegistrationDate
        });

        organizationsByOwner[msg.sender] = org;
        organizationsById[organizationId] = org;

        emit OrganizationRegistered(
            msg.sender,
            organizationId,
            organizationName,
            legalRegistrationDate,
            nowTs
        );
    }

    // -------------------------------------------------------------------------
    // Transfer ownership
    // -------------------------------------------------------------------------

    function transferOrganizationOwnership(address newOwner) external {
        if (newOwner == address(0)) revert Unauthorized();

        Organization memory org = organizationsByOwner[msg.sender];

        if (org.organizationId == bytes32(0))
            revert OrganizationNotRegistered();

        if (organizationsByOwner[newOwner].organizationId != bytes32(0))
            revert AlreadyRegistered();

        organizationsByOwner[newOwner] = org;
        delete organizationsByOwner[msg.sender];
    }

    // -------------------------------------------------------------------------
    // Issue Certificate
    // -------------------------------------------------------------------------

    function issueCertificate(
        bytes32 certificateId,
        bytes32 certificateHash
    ) external {
        Organization storage org = organizationsByOwner[msg.sender];

        if (org.organizationId == bytes32(0))
            revert OrganizationNotRegistered();

        if (certificateId == bytes32(0)) revert InvalidCertificateId();

        if (certificateHash == bytes32(0)) revert InvalidCertificateHash();

        if (certificatesByHash[certificateHash].organizationId != bytes32(0))
            revert CertificateAlreadyExists();

        uint64 issuedAt = uint64(block.timestamp);

        certificatesByHash[certificateHash] = Certificate({
            organizationId: org.organizationId,
            certificateId: certificateId,
            issuedAt: issuedAt
        });

        emit CertificateIssued(
            org.organizationId,
            certificateId,
            certificateHash,
            issuedAt
        );
    }

    // -------------------------------------------------------------------------
    //  Verify Certificate
    // -------------------------------------------------------------------------

    function verifyCertificate(
        bytes32 certificateHash
    )
        external
        view
        returns (
            bool valid,
            string memory organizationName,
            bytes32 organizationId,
            bytes32 certificateId,
            uint256 issuedAt
        )
    {
        Certificate memory cert = certificatesByHash[certificateHash];

        if (cert.organizationId == bytes32(0)) {
            return (false, "", bytes32(0), "", 0);
        }

        Organization memory org = organizationsById[cert.organizationId];

        return (
            true,
            org.organizationName,
            cert.organizationId,
            cert.certificateId,
            cert.issuedAt
        );
    }

    // -------------------------------------------------------------------------
    // Helpers
    // -------------------------------------------------------------------------

    function getOrganizationDetails(
        address wallet
    ) external view returns (Organization memory) {
        return organizationsByOwner[wallet];
    }

    function getCertificate(
        bytes32 certificateHash
    ) external view returns (Certificate memory) {
        return certificatesByHash[certificateHash];
    }
}
