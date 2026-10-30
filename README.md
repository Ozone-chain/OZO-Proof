# OZO Proof

**Verify Certificates. Without Storing Them.**

OZO Proof is a blockchain-based certificate verification platform that
enables trusted issuers to create tamper-proof proofs for certificates
and allows anyone to verify their authenticity.

Instead of storing certificate documents, OZO Proof records only their
cryptographic fingerprints (hashes) on the blockchain. The original
certificate remains on the user's device.

🌐 **Website:** https://ozoproof.com/\
🚀 **Application:** https://app.ozoproof.com/

------------------------------------------------------------------------

## Overview

Traditional certificate verification can require centralized databases,
manual checks, and the sharing or storage of sensitive documents.

OZO Proof uses cryptographic hashing and blockchain technology to
provide a privacy-first verification process:

-   Certificate files are hashed locally in the browser.
-   Only the cryptographic proof is recorded on-chain.
-   The original certificate document is not uploaded to a centralized
    storage server by the described workflow.
-   Anyone can verify a certificate by uploading the same file.
-   Any modification to the file produces a different hash and causes
    verification to fail.

## How It Works

### 1. Upload a Certificate

An issuer selects a certificate PDF in the browser. The file is
processed locally on the user's device.

### 2. Create an On-Chain Proof

OZO Proof generates a cryptographic fingerprint of the certificate and
records the proof on the blockchain. The certificate itself is not
stored on-chain.

### 3. Verify the Certificate

A verifier uploads the certificate file to check its authenticity.

-   **Same file:** The generated fingerprint matches the recorded proof.
-   **Modified file:** The fingerprint differs, and verification fails.

## Key Features

### Privacy-First Certificate Processing

Certificate hashing takes place directly in the browser. The original
document remains on the user's device during the described workflow.

### Blockchain-Based Proofs

Only cryptographic fingerprints are recorded on-chain, providing a
transparent verification reference without storing certificate
documents.

### Public Verification

Anyone can verify a certificate by uploading the corresponding file. The
verification workflow does not require a verifier login or special
permission.

### Tamper Detection

A change to the certificate changes its cryptographic fingerprint. This
allows the verification process to detect modified files.

### Issuer-Friendly Workflow

Trusted institutions can issue certificate proofs without maintaining
their own certificate-verification database or document-storage
infrastructure.

### Permissionless Verification Layer

Blockchain provides a shared verification layer that does not depend on
a single centralized verification authority.

## Who Is It For?

### Certificate Issuers

Institutions and organizations that issue certificates can create
permanent cryptographic proofs for their documents.

Typical workflow:

1.  Open the OZO Proof application.
2.  Select the certificate PDF.
3.  Generate and record its proof.
4.  Share the certificate with its recipient.

### Certificate Verifiers

Employers, institutions, organizations, and individuals can check
whether a certificate matches its recorded proof.

Typical workflow:

1.  Open the verification application.
2.  Upload the certificate PDF.
3.  Review the verification result.

## Privacy and Security Principles

OZO Proof is designed around the following principles:

-   **No document storage on-chain:** Certificate files are not recorded
    on the blockchain.
-   **Local hashing:** The certificate fingerprint is generated in the
    browser.
-   **Minimal on-chain data:** Only the cryptographic proof is recorded.
-   **Public verifiability:** Proofs can be checked without relying on a
    private verification database.
-   **Tamper evidence:** Changes to a file result in a different
    cryptographic fingerprint.

> Important: A matching cryptographic proof establishes that the
> uploaded file matches the file represented by the recorded proof. It
> does not, by itself, establish that the issuer is legitimate or that
> the certificate's original claims are true. Issuer trust and the
> integrity of the issuance process remain important.

## Getting Started

OZO Proof is available through its web application:

-   **Main website:** https://ozoproof.com/
-   **Application:** https://app.ozoproof.com/

Use the application to issue certificate proofs or verify an existing
certificate.

## Project Links

  Resource             Link
  -------------------- ---------------------------
  Official Website     https://ozoproof.com/
  Web Application      https://app.ozoproof.com/
  Terms & Conditions   https://ozoproof.com/
  Privacy Policy       https://ozoproof.com/

## License

No repository license information was provided here. Add a `LICENSE`
file and update this section before treating the project as open source.

------------------------------------------------------------------------

**OZO Proof --- Verify once. Trust forever.**
