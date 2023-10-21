# Mood Friend Product Requirement Document (PRD)

## Overview

Mood Friend is a decentralized application (dApp) designed to help users track various aspects of their daily well-being through "Life Metrics". By analyzing these metrics and their correlations, users can gain insights into their emotional and physical well-being, enabling them to make informed decisions to enhance their quality of life.

## Objective

To provide a user-friendly platform where individuals can consistently monitor various life metrics, identify patterns, and make informed decisions to improve their overall well-being.

## Business Model

### Pricing Model

- Users will be charged on a yet-to-be-determined cadence for accessing the app's premium features.

### Incentives

- Users who maintain a specific activity streak (e.g., logging metrics for X consecutive days) will receive X% of their payment back as a reward.
- The exact percentage and streak duration will be finalized after assessing the business operation costs, especially the cost of minting cNFTs on Solana.

## Technology

### Tech Stack

- **Blockchain**: Solana
- **Backend/API Server**: Bun (with ReScript bindings)
  - **Bundler, Test Runner**: Bun
- **Frontend**: ReScript React
  - **Bundler, Test Runner**: Bun
- **Additional Technologies**: cNFTs, DAS, Helius
- **Package Manager**: Bun

### Data Management

- **Storage**: Data will be stored on the Solana blockchain in the form of cNFTs (cryptographic Non-Fungible Tokens).
- **Security**:
  - The data will be encrypted before storage to ensure user privacy and data integrity.
  - Decryption will occur on the client-side using the user's Solana keypair, ensuring that only the user has access to their personal data.

## Features

### Life Metrics Tracking

Users can log various metrics daily, including:

- **High Mood**: Options include psychotic mania, mania, exuberance, happiness, neutral.
- **Low Mood**: Options include psychotic depression, depression, mild depression, sadness, neutral.
- **Sleep Disturbance**: Options are Yes/No.
- **Loss of Appetite**: Options are Yes/No.
- **Irritability**: Options are Yes/No.
- **Exercise**: Options are Yes/No.
- **Medication**: Options are Yes/No.
- **Talk Therapy**: Options are Yes/No.
- **Caffeine Intake**: Options are Yes/No.
- **Notes**: Text input for any additional information or specific events.

### Analysis & Insights

- The app will analyze the user's entries to identify patterns and correlations across different life metrics.
- Users can view graphical representations of their trends over time.
- Recommendations or tips based on the user's patterns.

### Streaks & Rewards

- Users can view their current streak of daily entries.
- Details of potential cashbacks based on their streak.

## MVP

The primary goal of the MVP is to validate the core idea of "Mood Friend" and demonstrate its feasibility and potential value to users. The MVP will focus on the following key components:

### 1. **User Registration & Authentication**:

- Allow users to register and authenticate using their Solana keypair.
- Ensure secure and seamless user experience.

### 2. **Basic Life Metrics Tracking**:

- Implement the ability for users to log their daily metrics, focusing on the most critical ones like "High Mood", "Low Mood", and "Notes".
- Provide a simple user interface for data input.

### 3. **Data Storage & Retrieval**:

- Store the logged metrics on the Solana blockchain in the form of cNFTs.
- Ensure that data is encrypted before storage and can be decrypted on the client-side.

### 4. **Basic Visualization**:

- Display a simple timeline or calendar view where users can see their logged metrics for the past days.

### Deliverables:

- A functional dApp where users can register, log their metrics, and view their data.
- Documentation detailing the technical architecture, challenges faced, and potential solutions for the next phases.
- User feedback collection mechanism to gather insights and validate the value proposition of the dApp.

### Success Criteria:

- Successful storage and retrieval of encrypted user data on the Solana blockchain.
- Positive initial user feedback regarding the dApp's concept and usability.

## Additional Considerations

### Legal & Compliance:

- Ensure compliance with data protection and privacy laws, especially if targeting a global audience. In the USA, consider regulations like the California Consumer Privacy Act (CCPA) and the General Data Protection Regulation (GDPR) for European users.
- Consider terms of service, privacy policies, and disclaimers to protect both the users and the platform.

### Localization & Internationalization:

- Given the tech stack, consider using libraries or tools that support internationalization (i18n) and localization (l10n) in React. This will allow for easy translation and adaptation of the app for different languages and regions in the future.

### Feedback Mechanism:

- Implement a mechanism within the app for users to provide feedback, report issues, or suggest features.

### Updates & Maintenance:

- Regularly communicate updates, bug fixes, and new features to users via platforms like GitHub and Twitter.

### Security Audits:

- Plan for security audits, especially given the financial and personal data involved, to ensure there are no vulnerabilities.

## Future Features to Consider

- Integration with other health and wellness apps to gather more comprehensive data.
- Explore additional mechanisms for increasing profits without promoting speculation or pyramid scheming.
- Community features where users can share experiences and support each other.
