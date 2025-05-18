;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Blocks-World 6-BLOCK TOWER  (annotated)
;;  Purpose   : Scalability / optimal-plan experiment for Level-5 report
;;  Domain    : blocks_world_level5.pddl  (unchanged)
;;  Challenge : Build a 5-high tower F-E-D-C-B resting on base A
;;              → Optimal plan length = 15 moves (pickup/stack pairs)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (problem bw6_blocks_goal_tower)
  ;;---------------------------------------------------------------------------
  ;; Reference the domain that defines types, predicates, actions
  ;;---------------------------------------------------------------------------
  (:domain blocks_world_level5)

  ;;---------------------------------------------------------------------------
  ;; Object universe — six homogeneous blocks
  ;;  • More blocks => larger branching factor and longer optimal plan
  ;;  • Typed as ‘block’ (type declared in domain)
  ;;---------------------------------------------------------------------------
  (:objects A B C D E F - block)

  ;;---------------------------------------------------------------------------
  ;; Initial state — all blocks separate, each clear, hand empty
  ;;  • Represents an unordered workspace at time 0
  ;;---------------------------------------------------------------------------
  (:init
     ;; every block starts on the table
     (ontable A) (ontable B) (ontable C) (ontable D) (ontable E) (ontable F)

     ;; nothing on top of any block
     (clear A)   (clear B)   (clear C)   (clear D)   (clear E)   (clear F)

     ;; robot’s hand is free
     (handempty)
  )

  ;;---------------------------------------------------------------------------
  ;; Goal condition — one specific 5-high tower
  ;;   F
  ;;   E
  ;;   D
  ;;   C
  ;;   B
  ;;   A (base on table)
  ;; plus: top block F must be clear when finished
  ;;---------------------------------------------------------------------------
  (:goal
     (and (on B A)    ; B sits on base A
          (on C B)    ; …
          (on D C)
          (on E D)
          (on F E)    ; F is the top
          (ontable A) ; entire stack grounded on table
          (clear F))) ; top is clear => no block above F
)




