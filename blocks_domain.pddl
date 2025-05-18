; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;;  BLOCKS-WORLD 
; ;;  - Declarative STRIPS domain with typing
; ;;  - No derived predicates, conditional effects or costs
; ;;  - Compatible with any classical planner/validator
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain blocks_world_level5)

  ;;---------------------------------------------------------------------------
  ;; :requirements tell the planner which PDDL features we use
  ;;   :strips   – basic add/delete lists
  ;;   :typing   – allow explicit type declarations
  ;;---------------------------------------------------------------------------
  (:requirements :strips :typing)

  ;;---------------------------------------------------------------------------
  ;; :types – only one type is needed in classical Blocks-World
  ;;---------------------------------------------------------------------------
  (:types block)

  ;;---------------------------------------------------------------------------
  ;; :predicates – state fluents the planner reasons about
  ;;---------------------------------------------------------------------------
  (:predicates
      ;; (on b p)          – block b is directly on top of block p
      (on ?b - block ?p - block)

      ;; (ontable b)       – block b rests directly on the table
      (ontable ?b - block)

      ;; (clear b)         – nothing is on top of block b → can pick/stack
      (clear ?b - block)

      ;; (holding b)       – robot hand is grasping block b
      (holding ?b - block)

      ;; (handempty)       – robot hand is free (not holding anything)
      (handempty)
  )

  ;;============================== OPERATORS ==================================
  ;; Each :action encodes the PRECONDITIONS under which it is legal
  ;; and the EFFECTS (add & delete lists) that result.
  ;;===========================================================================
  
  ;;-------------------------------------------------------------------------
  ;; PICKUP – grab a clear block from the table
  ;;   pre: block is clear & on table, hand empty
  ;;   eff: now holding it; it is no longer on table or clear; hand not empty
  ;;-------------------------------------------------------------------------
  (:action pickup
    :parameters (?x - block)
    :precondition (and (clear ?x) (ontable ?x) (handempty))
    :effect (and (holding ?x)
                 (not (ontable ?x))
                 (not (clear ?x))
                 (not (handempty))))

  ;;-------------------------------------------------------------------------
  ;; PUTDOWN – place the held block back on the table
  ;;-------------------------------------------------------------------------
  (:action putdown
    :parameters (?x - block)
    :precondition (holding ?x)
    :effect (and (ontable ?x)
                 (clear ?x)
                 (handempty)
                 (not (holding ?x))))

  ;;-------------------------------------------------------------------------
  ;; UNSTACK – lift block X off block Y
  ;;   pre: X sits on Y, X is clear, hand empty
  ;;   eff: now holding X; Y becomes clear; on(X,Y) no longer true
  ;;-------------------------------------------------------------------------
  (:action unstack
    :parameters (?x - block ?y - block)
    :precondition (and (on ?x ?y) (clear ?x) (handempty))
    :effect (and (holding ?x)
                 (clear ?y)
                 (not (on ?x ?y))
                 (not (clear ?x))
                 (not (handempty))))

  ;;-------------------------------------------------------------------------
  ;; STACK – put the held block X onto clear block Y
  ;;-------------------------------------------------------------------------
  (:action stack
    :parameters (?x - block ?y - block)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (on ?x ?y)
                 (clear ?x)          ; top of new stack is now clear
                 (handempty)
                 (not (holding ?x))
                 (not (clear ?y))))  ; Y is no longer clear
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  BLOCKS-WORLD with NON-DETERMINISM (PPDDL)
;;  - adds stochastic slip on stack
;;  - adds non-deterministic grip failure on pickup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (define (domain blocks_world_level5_nd)

;   (:requirements :strips :typing :probabilistic :nondeterministic)
;   (:types block)

;   (:predicates
;       (on ?b - block ?p - block)
;       (ontable ?b - block)
;       (clear ?b - block)
;       (holding ?b - block)
;       (handempty))

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;  ACTIONS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ;; ---------- 1. PICKUP (may fail to grip) ----------
; (:action pickup
;   :parameters (?x - block)
;   :precondition (and (clear ?x) (ontable ?x) (handempty))
;   :effect
;     (oneof
;       ;; successful grip
;       (and (holding ?x)
;           (not (ontable ?x))
;           (not (clear ?x))
;           (not (handempty)))
;       ;; failed grip – nothing changes
;       (and (ontable ?x)
;           (clear ?x)
;           (handempty))))

; ;; ---------- 2. PUTDOWN (always succeeds) ----------
; (:action putdown
;   :parameters (?x - block)
;   :precondition (holding ?x)
;   :effect (and (ontable ?x)
;               (clear ?x)
;               (handempty)
;               (not (holding ?x))))

; ;; ---------- 3. UNSTACK (always succeeds) ----------
; (:action unstack
;   :parameters (?x - block ?y - block)
;   :precondition (and (on ?x ?y) (clear ?x) (handempty))
;   :effect (and (holding ?x)
;               (clear ?y)
;               (not (on ?x ?y))
;               (not (clear ?x))
;               (not (handempty))))

; ;; ---------- 4. STACK (80 % success, 20 % slip) ----------
; (:action stack
;   :parameters (?x - block ?y - block)
;   :precondition (and (holding ?x) (clear ?y))
;   :effect
;     (probabilistic
;       0.8  ; normal success
;       (and (on ?x ?y)
;           (clear ?x)
;           (handempty)
;           (not (holding ?x))
;           (not (clear ?y)))
;       0.2  ; slip: block drops back onto table
;       (and (ontable ?x)
;           (clear ?x)
;           (handempty)
;           (not (holding ?x)))))
; )
