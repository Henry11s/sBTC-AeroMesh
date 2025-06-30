

# sBTC-AeroMesh - Weather Data Oracle Contract

A decentralized, Clarity-based smart contract for managing **IoT weather devices**, handling **data submission**, ensuring **data validation through consensus**, and facilitating **reward/penalty mechanisms** along with a **governance system** for parameter tuning.

---

## 📘 Table of Contents

* [Overview](#overview)
* [Key Features](#key-features)
* [Contract Constants](#contract-constants)
* [Error Codes](#error-codes)
* [Data Structures](#data-structures)
* [Public Functions](#public-functions)
* [Private Helpers](#private-helpers)
* [Governance System](#governance-system)
* [Deployment Considerations](#deployment-considerations)
* [Future Improvements](#future-improvements)
* [License](#license)

---

## 🛰️ Overview

This smart contract enables decentralized weather data collection via IoT devices. Devices must be registered and staked, after which they can submit environmental data (temperature, humidity, pressure, wind speed). Data is validated against consensus data, and valid submissions earn rewards. Devices with low accuracy or inactivity are penalized. A governance system allows staked participants to propose and vote on parameter changes.

---

## ⚙️ Key Features

* 📍 **Device Registration** with staking requirement
* 📝 **Data Submission** of environmental metrics
* ✅ **Data Validation** against consensus values
* 🎁 **Rewards** for validated submissions
* ⚠️ **Penalties** for inaccuracy or inactivity
* 🗳️ **Governance Proposals & Voting**
* 🔐 **Owner and Stake-based Permissions**

---

## 🔢 Contract Constants

| Constant                | Description                                      | Value     |
| ----------------------- | ------------------------------------------------ | --------- |
| `min-stake`             | Minimum STX to stake a device                    | `100 STX` |
| `reward-per-submission` | Reward per valid data entry                      | `1 STX`   |
| `max-deviation`         | Allowed deviation from consensus                 | `10%`     |
| `min-validators`        | Minimum validators for consensus                 | `3`       |
| `accuracy-threshold`    | Accuracy score below which devices are penalized | `80`      |
| `penalty-amount`        | Penalty for malfunction/inaccuracy               | `10 STX`  |
| `max-inactive-blocks`   | Max blocks without submission                    | `1440`    |
| `governance-threshold`  | Proposal pass percentage                         | `75%`     |

---

## 🚨 Error Codes

| Error Code | Description                     |
| ---------- | ------------------------------- |
| `401`      | Not authorized                  |
| `402`      | Device already exists           |
| `403`      | Invalid stake amount            |
| `404`      | Device not found                |
| `405`      | Invalid data                    |
| `406`      | Consensus validation failed     |
| `407`      | Accuracy too low                |
| `408`      | Device inactive                 |
| `409`      | Insufficient stake for proposal |
| `410`      | Invalid proposal                |

---

## 🧩 Data Structures

The contract maintains multiple `maps` and `vars`:

* **`devices`**: Device metadata, ownership, stake, accuracy
* **`weather-data`**: Raw data submissions
* **`consensus-data`**: Aggregated data for validation
* **`device-metrics`**: Activity, rewards, penalties
* **`proposals`**: Governance proposals
* **`votes-cast`**: Voting records
* **`device-owners`**: Reverse lookup from principal to device ID

---

## 📤 Public Functions

### ✅ Registration & Staking

```clarity
(register-device (device-id) (latitude) (longitude))
(stake-device (device-id) (amount))
```

### 🌦️ Data Submission & Validation

```clarity
(submit-data (device-id) (timestamp) (temperature) (humidity) (pressure) (wind-speed))
(validate-data (device-id) (timestamp) (location-hash))
```

### ⚖️ Quality Control

```clarity
(report-malfunction (device-id))
(update-device-status (device-id))
```

### 🗳️ Governance

```clarity
(create-proposal (title) (description) (parameter) (new-value))
(vote-on-proposal (proposal-id) (vote-value))
```

### 📚 Read-only Queries

```clarity
(get-device-info (device-id))
(get-weather-data (device-id) (timestamp))
(get-consensus-data (location-hash) (timestamp))
(get-device-by-owner (owner))
(get-owner-device (owner))
```

---

## 🛠️ Private Helpers

### Data Deviation Validator

```clarity
(validate-measurement (value int) (consensus int))
(abs (value int))
```

---

## 🏛️ Governance System

* Only users with devices staked at **≥ 200 STX** can create proposals.
* Proposals remain **active for 1440 blocks** (\~1 day).
* Voters can vote **once per proposal**.
* Voting is based on **device ownership**.
* A proposal passes if **`votes-for / total votes ≥ 75%`**.

---

## ⚠️ Deployment Considerations

* Oracle validators must be off-chain services updating `consensus-data`.
* The `contract-owner` is statically set to the deploying address.
* There’s **no slashing logic yet** for inaccurate consensus aggregators.

---

## 🚧 Future Improvements

* Add `unregister-device` with stake withdrawal logic.
* On-chain slashing for poor performance or malicious data.
* Auto-distribution of proposal execution logic.
* NFT badges for high-performing devices.

---

## 📄 License

MIT License © 2025 YourName or YourOrganization

---
