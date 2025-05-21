;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  PROBLEM INSTANCE  —  4×4 grid, same pits & Wumpus as Task-3
;;  Compatible with wumpus_world_killfirst.pddl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (problem wumpus_instance_killfirst)
  (:domain wumpus_world_killfirst)

  (:objects
      ;; 16 grid squares (type square)
      sq-1-1 sq-1-2 sq-1-3 sq-1-4
      sq-2-1 sq-2-2 sq-2-3 sq-2-4
      sq-3-1 sq-3-2 sq-3-3 sq-3-4
      sq-4-1 sq-4-2 sq-4-3 sq-4-4     - square

      the-gold the-arrow              - object
      hunter1                         - hunter)

  (:init
      ;;————————————————  HORIZONTAL EDGES  ————————————————
      (adj sq-1-1 sq-2-1) (adj sq-2-1 sq-1-1)
      (adj sq-2-1 sq-3-1) (adj sq-3-1 sq-2-1)
      (adj sq-3-1 sq-4-1) (adj sq-4-1 sq-3-1)
      (adj sq-1-2 sq-2-2) (adj sq-2-2 sq-1-2)
      (adj sq-2-2 sq-3-2) (adj sq-3-2 sq-2-2)
      (adj sq-3-2 sq-4-2) (adj sq-4-2 sq-3-2)
      (adj sq-1-3 sq-2-3) (adj sq-2-3 sq-1-3)
      (adj sq-2-3 sq-3-3) (adj sq-3-3 sq-2-3)
      (adj sq-3-3 sq-4-3) (adj sq-4-3 sq-3-3)
      (adj sq-1-4 sq-2-4) (adj sq-2-4 sq-1-4)
      (adj sq-2-4 sq-3-4) (adj sq-3-4 sq-2-4)
      (adj sq-3-4 sq-4-4) (adj sq-4-4 sq-3-4)

      ;;————————————————  VERTICAL EDGES  ————————————————
      (adj sq-1-1 sq-1-2) (adj sq-1-2 sq-1-1)
      (adj sq-1-2 sq-1-3) (adj sq-1-3 sq-1-2)
      (adj sq-1-3 sq-1-4) (adj sq-1-4 sq-1-3)
      (adj sq-2-1 sq-2-2) (adj sq-2-2 sq-2-1)
      (adj sq-2-2 sq-2-3) (adj sq-2-3 sq-2-2)
      (adj sq-2-3 sq-2-4) (adj sq-2-4 sq-2-3)
      (adj sq-3-1 sq-3-2) (adj sq-3-2 sq-3-1)
      (adj sq-3-2 sq-3-3) (adj sq-3-3 sq-3-2)
      (adj sq-3-3 sq-3-4) (adj sq-3-4 sq-3-3)
      (adj sq-4-1 sq-4-2) (adj sq-4-2 sq-4-1)
      (adj sq-4-2 sq-4-3) (adj sq-4-3 sq-4-2)
      (adj sq-4-3 sq-4-4) (adj sq-4-4 sq-4-3)

      ;;————————————————  WORLD STATE  ————————————————
      (at-object the-gold  sq-2-3)   ; treasure
      (at-hunter hunter1   sq-1-1)   ; hunter starts
      (have      hunter1   the-arrow)

      (wumpus-at sq-1-3)             ; live Wumpus
      (pit sq-3-1) (pit sq-4-4) )

  (:goal
      (and (have hunter1 the-gold)
           (at-hunter hunter1 sq-1-1)) )
)
