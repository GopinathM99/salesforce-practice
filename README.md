# Salesforce Practice

This repository contains a Salesforce DX (SFDX) project for practicing and demonstrating Salesforce development concepts, including Apex classes, triggers, Lightning Web Components (LWC), and metadata configuration.

## Project Structure

- `force-app/main/default/` - Main source directory for Salesforce metadata.
  - `classes/` - Apex classes and test classes.
  - `triggers/` - Apex triggers.
  - `lwc/` - Lightning Web Components.
  - `objects/` - Custom and standard object metadata.
  - `applications/` - Custom and standard Salesforce applications.
  - Other folders for layouts, pages, permissionsets, profiles, staticresources, etc.
- `manifest/` - Deployment and package manifest files (`package.xml`).
- `sfdx-project.json` - SFDX project configuration.

## Setup Instructions

1. **Install Salesforce CLI (SFDX):**
   - [Download and install Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli)

2. **Authenticate to a Dev Hub:**
   ```sh
   sfdx auth:web:login -d -a DevHub
   ```

3. **Create a Scratch Org:**
   ```sh
   sfdx force:org:create -s -f config/project-scratch-def.json -a MyScratchOrg
   ```

4. **Push Source to Scratch Org:**
   ```sh
   sfdx force:source:push
   ```

5. **Open the Scratch Org:**
   ```sh
   sfdx force:org:open
   ```

6. **Run Apex Tests:**
   ```sh
   sfdx force:apex:test:run --resultformat human --outputdir test-results --wait 10
   ```

## Usage
- Use this project to practice Salesforce development, test new features, and experiment with metadata deployments.
- Contribute new Apex classes, triggers, LWCs, and configuration as needed.

## Resources
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev)
- [Apex Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode)
- [Lightning Web Components](https://developer.salesforce.com/docs/component-library/documentation/en/lwc)

---
Feel free to fork and use this repository for your Salesforce learning journey!

