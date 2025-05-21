(define (problem wumpus_instance)
  (:domain wumpus_world_fixed)

  (:objects
      sq-1-1 sq-1-2 sq-1-3 sq-1-4
      sq-2-1 sq-2-2 sq-2-3 sq-2-4
      sq-3-1 sq-3-2 sq-3-3 sq-3-4
      sq-4-1 sq-4-2 sq-4-3 sq-4-4 - square
      the-gold the-arrow - object
      hunter1 - hunter)

  (:init
      ;; ---------- Adjacencies (horizontal) ----------
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

      ;; ---------- Adjacencies (vertical) ----------
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

      ;; ---------- World facts ----------
      (at-object the-gold  sq-2-3)
      (have      hunter1   the-arrow)      ;; hunter starts with arrow
      (at-hunter hunter1   sq-1-1)
      (wumpus-at           sq-1-3)
      (pit sq-3-1) (pit sq-4-4)
  )

  (:goal
      (and (have hunter1 the-gold)
           (at-hunter hunter1 sq-1-1))
  )
)
