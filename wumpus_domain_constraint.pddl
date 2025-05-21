;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  WUMPUS_WORLD_KILLFIRST  —  fully typed, STRIPS-only
;;  Key difference from Task-3 domain:  TAKE now requires (wumpus-dead)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain wumpus_world_killfirst)

  (:requirements :strips :typing)
  (:types hunter object square)

  ;;—————————————————— PREDICATES ——————————————————
  (:predicates
      (adj ?a - square ?b - square)        ; undirected adjacency
      (pit ?s - square)                    ; static hazard
      (wumpus-at ?s - square)              ; live Wumpus
      (wumpus-dead)                        ; becomes true after shoot
      (at-hunter ?h - hunter ?s - square)  ; hunter location
      (at-object ?o - object ?s - square)  ; gold or arrow when not carried
      (have ?h - hunter ?o - object))      ; inventory

  ;;—————————————— ACTIONS ———————————————

  ;; 1) MOVE  — hunter walks to adjacent safe square
  (:action move
    :parameters (?h - hunter ?from - square ?to - square)
    :precondition (and (adj ?from ?to)
                       (at-hunter ?h ?from)
                       (not (pit ?to))
                       (or (wumpus-dead)     ; forbidden while Wumpus alive
                           (not (wumpus-at ?to))))
    :effect (and (not (at-hunter ?h ?from))
                 (at-hunter ?h ?to)))

  ;; 2) TAKE  — hunter picks up object *only after Wumpus is dead*
  (:action take
    :parameters (?h - hunter ?o - object ?s - square)
    :precondition (and (wumpus-dead)        ; >>> new safety constraint
                       (at-hunter ?h ?s)
                       (at-object ?o ?s))
    :effect (and (have ?h ?o)
                 (not (at-object ?o ?s))))

  ;; 3) SHOOT — consumes arrow, marks Wumpus dead
  (:action shoot
    :parameters (?h - hunter
                 ?a - object      ; arrow
                 ?hs - square     ; hunter square
                 ?ws - square)    ; Wumpus square
    :precondition (and (have ?h ?a)
                       (at-hunter ?h ?hs)
                       (wumpus-at ?ws)
                       (adj ?hs ?ws)
                       (not (wumpus-dead)))
    :effect (and (wumpus-dead)
                 (not (have ?h ?a))) )      ; arrow is single-use
)
