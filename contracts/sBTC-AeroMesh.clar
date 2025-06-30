
;; sBTC-AeroMesh

;; Constants
(define-constant contract-owner tx-sender)
(define-constant min-stake u100000000) ;; 100 STX minimum stake
(define-constant reward-per-submission u1000000) ;; 1 STX per valid submission
(define-constant max-deviation 10) ;; 10% maximum deviation for consensus
(define-constant min-validators u3) ;; Minimum validators for consensus

;; Error codes
(define-constant ERR-NOT-AUTHORIZED (err u401))
(define-constant ERR-DEVICE-EXISTS (err u402))
(define-constant ERR-INVALID-STAKE (err u403))
(define-constant ERR-DEVICE-NOT-FOUND (err u404))
(define-constant ERR-INVALID-DATA (err u405))
(define-constant ERR-CONSENSUS-FAILED (err u406))

(define-constant ACCURACY-THRESHOLD u80) ;; Minimum accuracy score
(define-constant PENALTY-AMOUNT u10000000) ;; 10 STX penalty
(define-constant MAX-INACTIVE-BLOCKS u1440) ;; Max blocks without submission
(define-constant GOVERNANCE-THRESHOLD u75) ;; 75% for proposal passing

;; Additional Error Codes
(define-constant ERR-LOW-ACCURACY (err u407))
(define-constant ERR-INACTIVE-DEVICE (err u408))
(define-constant ERR-INSUFFICIENT-STAKE (err u409))
(define-constant ERR-INVALID-PROPOSAL (err u410))


;; Device tracking
(define-map device-index uint (string-ascii 24))
(define-map device-owners principal (string-ascii 24))
(define-data-var device-counter uint u0)

(define-data-var proposal-counter uint u0)


;; Data structures
(define-map devices
    { device-id: (string-ascii 24) }
    {
        owner: principal,
        stake: uint,
        accuracy-score: uint,
        total-submissions: uint,
        location: {
            latitude: int,
            longitude: int
        }
    }
)

(define-map weather-data
    { 
        device-id: (string-ascii 24),
        timestamp: uint 
    }
    {
        temperature: int,
        humidity: uint,
        pressure: uint,
        wind-speed: uint,
        validated: bool
    }
)

(define-map consensus-data
    { 
        location-hash: (string-ascii 16),
        timestamp: uint 
    }
    {
        temperature-avg: int,
        humidity-avg: uint,
        pressure-avg: uint,
        wind-speed-avg: uint,
        submission-count: uint
    }
)



(define-map device-metrics
    { device-id: (string-ascii 24) }
    {
        last-submission-block: uint,
        consecutive-validations: uint,
        total-rewards: uint,
        total-penalties: uint
    }
)

(define-map proposals
    { proposal-id: uint }
    {
        proposer: principal,
        title: (string-ascii 50),
        description: (string-ascii 500),
        parameter: (string-ascii 20),
        new-value: uint,
        votes-for: uint,
        votes-against: uint,
        status: (string-ascii 10),
        end-block: uint
    }
)

(define-map votes-cast
    { proposal-id: uint, voter: principal }
    { vote: bool }
)

