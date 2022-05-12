## Local vs Global

`position` é relativo ao nó em si. Apropriado para fazer deslocamento.

`global_position` é relativo ao espaço global. Apropriado para fazer cálculos
com dimensões da tela(?).

https://godotengine.org/qa/40058/what-is-the-difference-between-global-and-local-coordinates

## Posição global ao adicionar nó filho

Definir a posição global de um nó antes dele ser adicionado
como filho de outro nó é inadequado.

https://github.com/godotengine/godot/issues/24182

Nesse jogo, esse bug poderia acontece em `Player.shoot()` se eu estivesse usando 
`global_position`. Se eu quisesse que a bala sugisse do canto superior esquerdo
da tela e fizesse assim:

<!-- eu sei que não é Python -->
```python
new_bullet.global_position = Vector2.ZERO
add_child(new_bullet)
```

Não daria certo. Desse jeito apenas `position` é setado porque na primeira
linha ainda não se sabe quem é o pai de `new_bullet`. O correto seria:

```python
add_child(new_bullet)
new_bullet.global_position = Vector2.ZERO
```

## Ícones

Gerar ícones para diferentes plataformas.

https://docs.godotengine.org/en/stable/tutorials/export/changing_application_icon_for_windows.html