;; Fact-Checker Verification Contract
;; Manages registration and verification of fact-checking organizations

(define-map fact-checkers
  { checker-id: uint }
  {
    address: principal,
    name: (string-ascii 100),
    verified: bool,
    reputation-score: uint,
    total-verifications: uint,
    registration-block: uint
  }
)

(define-map checker-addresses
  { address: principal }
  { checker-id: uint }
)

(define-data-var next-checker-id uint u1)
(define-data-var contract-owner principal tx-sender)

;; Register a new fact-checker
(define-public (register-fact-checker (name (string-ascii 100)))
  (let ((checker-id (var-get next-checker-id))
        (caller tx-sender))
    (asserts! (is-none (map-get? checker-addresses { address: caller })) (err u100))
    (map-set fact-checkers
      { checker-id: checker-id }
      {
        address: caller,
        name: name,
        verified: false,
        reputation-score: u50,
        total-verifications: u0,
        registration-block: block-height
      }
    )
    (map-set checker-addresses { address: caller } { checker-id: checker-id })
    (var-set next-checker-id (+ checker-id u1))
    (ok checker-id)
  )
)

;; Verify a fact-checker (only contract owner)
(define-public (verify-fact-checker (checker-id uint))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err u101))
    (match (map-get? fact-checkers { checker-id: checker-id })
      checker-data
      (begin
        (map-set fact-checkers
          { checker-id: checker-id }
          (merge checker-data { verified: true })
        )
        (ok true)
      )
      (err u102)
    )
  )
)

;; Get fact-checker info
(define-read-only (get-fact-checker (checker-id uint))
  (map-get? fact-checkers { checker-id: checker-id })
)

;; Check if address is verified fact-checker
(define-read-only (is-verified-checker (address principal))
  (match (map-get? checker-addresses { address: address })
    checker-info
    (match (map-get? fact-checkers { checker-id: (get checker-id checker-info) })
      checker-data (get verified checker-data)
      false
    )
    false
  )
)

;; Update reputation score (internal function)
(define-private (update-reputation (checker-id uint) (score-change int))
  (match (map-get? fact-checkers { checker-id: checker-id })
    checker-data
    (let ((current-score (get reputation-score checker-data))
          (new-score (if (> score-change 0)
                        (+ current-score (to-uint score-change))
                        (if (>= current-score (to-uint (- 0 score-change)))
                           (- current-score (to-uint (- 0 score-change)))
                           u0))))
      (map-set fact-checkers
        { checker-id: checker-id }
        (merge checker-data {
          reputation-score: new-score,
          total-verifications: (+ (get total-verifications checker-data) u1)
        })
      )
      (ok new-score)
    )
    (err u103)
  )
)
