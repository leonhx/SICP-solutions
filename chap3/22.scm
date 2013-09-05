#lang scheme

(define (make-queue)
  (let ([front-ptr null]
        [rear-ptr null])
    (define (set-front-ptr! item)
      (set! front-ptr item))
    (define (set-rear-ptr! item)
      (set! rear-ptr item))
    (define (empty-queue?)
      (null? front-ptr))
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue")
          (car front-ptr)))
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond [(empty-queue?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair)]
              [else
               (set-cdr! rear-ptr new-pair)
               (set-rear-ptr! new-pair)])))
    (define (delete-queue!)
      (cond [(empty-queue?)
             (error "DELETE! called with an empty queue")]
            [else
             (set-front-ptr! (cdr front-ptr))]))
    (define (dispatch m)
      (cond [(eq? m 'front-ptr) front-ptr]
            [(eq? m 'rear-ptr) rear-ptr]
            [(eq? m 'empty?) empty-queue?]
            [(eq? m 'front) (front-queue)]
            [(eq? m 'insert!) insert-queue!]
            [(eq? m 'delete!) (delete-queue!)]))
    dispatch))