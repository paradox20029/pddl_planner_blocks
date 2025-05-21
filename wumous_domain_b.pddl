(define (domain wumpus_world_fixed)

  (:requirements :strips :typing)
  (:types hunter object square)

  ;; ---------- Predicates ----------
  (:predicates
      (adj ?s1 - square ?s2 - square)   ;; undirected adjacency
      (pit ?s  - square)
      (wumpus-at ?s - square)           ;; live Wumpus
      (wumpus-dead)                     ;; becomes true after shoot
      (at-hunter ?h - hunter ?s - square)
      (at-object ?o - object ?s - square) ;; gold (and arrow if not carried)
      (have ?h - hunter ?o - object))

  ;; ---------- Actions ----------
  (:action move
    :parameters (?h - hunter ?from - square ?to - square)
    :precondition (and (adj ?from ?to)
                       (at-hunter ?h ?from)
                       (not (pit ?to))
                       (or (wumpus-dead) (not (wumpus-at ?to))))
    :effect (and (not (at-hunter ?h ?from))
                 (at-hunter ?h ?to)))

  (:action take
    :parameters (?h - hunter ?o - object ?s - square)
    :precondition (and (at-hunter ?h ?s) (at-object ?o ?s))
    :effect (and (have ?h ?o)
                 (not (at-object ?o ?s))))

  (:action shoot
    :parameters (?h - hunter ?a - object ?from - square ?w-sq - square)
    :precondition (and (have ?h ?a)
                       (at-hunter ?h ?from)
                       (wumpus-at ?w-sq)
                       (adj ?from ?w-sq)
                       (not (wumpus-dead)))
    :effect (and (wumpus-dead)
                 (not (have ?h ?a))) )
)
