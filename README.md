# Blockchain-Based Media Fact-Checking Networks

A decentralized fact-checking system built on the Stacks blockchain using Clarity smart contracts. This system enables transparent, verifiable fact-checking of media content through a network of verified fact-checkers and authenticated sources.

## Overview

The system consists of five interconnected smart contracts that work together to provide comprehensive media fact-checking:

1. **Fact-Checker Verification Contract** - Manages registration and verification of fact-checking organizations
2. **Content Verification Contract** - Handles verification of media content accuracy
3. **Source Authentication Contract** - Authenticates and manages information sources
4. **Credibility Scoring Contract** - Calculates comprehensive credibility scores
5. **Correction Tracking Contract** - Tracks corrections and updates to media content

## Features

### Fact-Checker Management
- Registration system for fact-checking organizations
- Verification process for legitimate fact-checkers
- Reputation scoring based on verification history
- Transparent track record of all verifications

### Content Verification
- Submit media content for fact-checking
- Multiple fact-checker verification requirement
- Consensus-based verification status
- Detailed verification records with evidence

### Source Authentication
- Domain-based source registration
- Credibility scoring for news sources
- Verification by trusted fact-checkers
- Historical performance tracking

### Credibility Scoring
- Multi-factor credibility assessment
- Weighted scoring algorithm
- Real-time score updates
- Human-readable credibility ratings

### Correction Tracking
- Comprehensive correction submission system
- Severity-based correction classification
- Verification of corrections by multiple fact-checkers
- Complete audit trail of all corrections

## Smart Contract Architecture

### Contract Interactions
\`\`\`
Fact-Checker Verification ←→ Content Verification
←→ Source Authentication
←→ Correction Tracking
↓
Credibility Scoring
\`\`\`

### Data Flow
1. Fact-checkers register and get verified
2. Sources register and build credibility
3. Content is submitted for verification
4. Verified fact-checkers assess content
5. Credibility scores are calculated
6. Corrections are tracked and verified

## Getting Started

### Prerequisites
- Stacks blockchain node or access to testnet
- Clarity development environment
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone https://github.com/your-org/blockchain-fact-checking.git
   cd blockchain-fact-checking
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks testnet:

\`\`\`bash
# Deploy fact-checker verification contract first
clarinet deploy --testnet contracts/fact-checker-verification.clar

# Deploy other contracts
clarinet deploy --testnet contracts/source-authentication.clar
clarinet deploy --testnet contracts/content-verification.clar
clarinet deploy --testnet contracts/credibility-scoring.clar
clarinet deploy --testnet contracts/correction-tracking.clar
\`\`\`

## Usage Examples

### Register as a Fact-Checker

\`\`\`clarity
(contract-call? .fact-checker-verification register-fact-checker "Reuters Fact Check")
\`\`\`

### Submit Content for Verification

\`\`\`clarity
(contract-call? .content-verification submit-content 0x1234567890abcdef...)
\`\`\`

### Verify Content

\`\`\`clarity
(contract-call? .content-verification verify-content
0x1234567890abcdef...
u1
"accurate"
u85
"Verified through multiple independent sources")
\`\`\`

### Register a News Source

\`\`\`clarity
(contract-call? .source-authentication register-source "example-news.com")
\`\`\`

### Submit a Correction

\`\`\`clarity
(contract-call? .correction-tracking submit-correction
0x1234567890abcdef...  ;; original content hash
0xfedcba0987654321...  ;; corrected content hash
"factual-error"
"Corrected statistical data from 2023 to 2024"
u7)  ;; severity level
\`\`\`

## API Reference

### Fact-Checker Verification Contract

#### Public Functions
- \`register-fact-checker(name)\` - Register as a fact-checker
- \`verify-fact-checker(checker-id)\` - Verify a fact-checker (owner only)

#### Read-Only Functions
- \`get-fact-checker(checker-id)\` - Get fact-checker information
- \`is-verified-checker(address)\` - Check if address is verified

### Content Verification Contract

#### Public Functions
- \`submit-content(content-hash)\` - Submit content for verification
- \`verify-content(content-hash, checker-id, verdict, confidence, evidence)\` - Verify content

#### Read-Only Functions
- \`get-content-status(content-hash)\` - Get verification status
- \`get-verification-details(content-hash, checker-id)\` - Get detailed verification

### Source Authentication Contract

#### Public Functions
- \`register-source(domain)\` - Register a news source
- \`verify-source(source-id)\` - Verify a source
- \`update-source-credibility(source-id, score-adjustment)\` - Update credibility

#### Read-Only Functions
- \`get-source(source-id)\` - Get source information
- \`get-source-by-domain(domain)\` - Get source by domain

### Credibility Scoring Contract

#### Public Functions
- \`calculate-credibility-score(content-hash, source-id)\` - Calculate score

#### Read-Only Functions
- \`get-credibility-score(content-hash)\` - Get detailed scores
- \`get-credibility-rating(content-hash)\` - Get rating string

### Correction Tracking Contract

#### Public Functions
- \`submit-correction(...)\` - Submit a correction
- \`verify-correction(correction-id, checker-id)\` - Verify correction

#### Read-Only Functions
- \`get-correction(correction-id)\` - Get correction details
- \`get-content-corrections(content-hash)\` - Get all corrections for content
- \`has-corrections(content-hash)\` - Check if content has corrections

## Error Codes

### Fact-Checker Verification (100-199)
- 100: Fact-checker already registered
- 101: Not authorized (not contract owner)
- 102: Fact-checker not found
- 103: Error updating reputation

### Content Verification (200-299)
- 200: Content already submitted
- 201: Not a verified fact-checker
- 202: Invalid confidence level
- 203: Content not found
- 204: Too many verifiers
- 205: Error updating content

### Source Authentication (300-399)
- 300: Domain already registered
- 301: Not a verified fact-checker
- 302: Source not found
- 303: Not authorized to update credibility
- 304: Error updating source

### Credibility Scoring (400-499)
- 401: Source not found
- 402: Content not found

### Correction Tracking (500-599)
- 500: Invalid severity level
- 501: Not a verified fact-checker
- 502: Too many corrections
- 503: Not authorized to verify
- 504: Too many verifiers
- 505: Correction not found

## Testing

The project includes comprehensive test suites for all contracts:

\`\`\`bash
# Run all tests
npm test

# Run specific test file
npm test fact-checker-verification.test.ts
\`\`\`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## Security Considerations

- All fact-checker verification requires contract owner approval
- Content verification requires multiple verified fact-checkers
- Source credibility updates are restricted to verified fact-checkers
- Correction submissions require fact-checker verification
- All operations are logged on-chain for transparency

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support, please open an issue on GitHub or contact the development team.
\`\`\`

## Roadmap

- [ ] Integration with IPFS for content storage
- [ ] Advanced reputation algorithms
- [ ] Multi-language support
- [ ] Mobile application interface
- [ ] Integration with major news platforms
- [ ] Machine learning-assisted fact-checking
- [ ] Decentralized governance mechanisms
  \`\`\`

Finally, let's create the PR details file:

