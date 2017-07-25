module TestTikZWiring

using Base.Test

using Catlab.Doctrine
using Catlab.Diagram.TikZWiring
import Catlab.Diagram.TikZWiring.Defaults
import Catlab.Diagram: TikZ

# We can't test that the pictures look right, but we can test that they exist!
is_pic(obj) = isa(obj, TikZ.Picture)

A, B = Ob(FreeCategory, :A, :B)
f, g = Hom(:f, A, B), Hom(:g, B, A)
@test is_pic(to_tikz(f))
@test is_pic(to_tikz(compose(f,g)))
@test is_pic(to_tikz(compose(id(A), f, id(B))))

A, B = Ob(FreeDaggerCategory, :A, :B)
f, g = Hom(:f, A, B), Hom(:g, B, A)
@test is_pic(to_tikz(dagger(f)))
@test is_pic(to_tikz(dagger(compose(f,g))))

A, B = Ob(FreeSymmetricMonoidalCategory, :A, :B)
f, g = Hom(:f, A, B), Hom(:g, B, A)
@test is_pic(to_tikz(otimes(f,g)))
@test is_pic(to_tikz(compose(otimes(f,g),braid(B,A))))

A, B = Ob(FreeBiproductCategory, :A, :B)
f, g = Hom(:f, A, B), Hom(:g, B, A)
@test is_pic(to_tikz(compose(mcopy(A), otimes(f,f), mmerge(B))))
@test is_pic(to_tikz(compose(create(A), f, g, delete(A))))

A, B = Ob(FreeCompactClosedCategory, :A, :B)
f, g = Hom(:f, A, B), Hom(:g, B, A)
h = Hom(:h, otimes(A,B), otimes(A,B))
@test is_pic(to_tikz(ev(A)))
@test is_pic(to_tikz(coev(A)))
trace = compose(
  f,
  otimes(coev(A), id(B)),
  otimes(id(dual(A)), h),
  otimes(braid(dual(A),A), id(B)),
  otimes(ev(A), id(B)),
  g,
)
@test is_pic(to_tikz(trace))

end
