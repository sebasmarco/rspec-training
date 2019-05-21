# RSpec - Framework de testing Ruby
## Proyecto introductorio

### Introducción

**RSpec** es uno de los frameworks de testing más utilizado por la comunidad de desarrolladores Ruby.
Este proyecto es el complemento de la Lightning Talk dada en Snappler para aprender los conceptos
básicos de la herramienta, además de fortalecer e incentivar la práctica del testing de software.

El enfoque de este `README` y del proyecto de ejemplo que se encuentra en este repositorio
es el framework de desarrollo web [Ruby on Rails](https://rubyonrails.org/).

### Conceptos básicos

RSpec permite crear tests mediante un esqueleto flexible y muy completo de bloques de *test cases*.
Los comandos para definir estructuras de testing son los siguientes:

- `describe:` Indica un bloque de ejecución de tests mediante una descripción de lo que se va a testear,
lo cual puede ser una clase, un método o una acción. Puede pensarse como una colección de tests.
- `context`:  Indica un bloque con el contexto donde se van a ejecutar los tests.
Generalmente se describe como un escenario con condiciones en donde una funcionalidad se puede ejecutar.
Al escribir un contexto, su descripción comienza generalmente con “cuando” (*when*) o “con” (*with*).
Puede pensarse como un subconjunto de tests de un mismo escenario condicional dentro de un describe
(aunque no necesariamente contenido por un `describe`).
- `it`: Describe el test particular que se va a ejecutar, es decir, el *test case*.
Se los conocen como **ejemplos** (*examples*).
- `expect`: Es el encargado de verificar un resultado, haciendo fallar el test si el resultado esperado difiere del obtenido.

Además de los comandos de definición de estructura de los tests, existen otras palabras reservadas
que permiten definir una única vez un objeto a testear o variables, de forma tal de que tengan vida
en el `describe` o `context` donde son definidos:

- `subject`: Describe un sujeto de pruebas, es decir, el objeto a ser testeado.
Su uso es opcional y es recomendable cuando un conjunto de tests utilizan un bloque de código común
que va a generar acciones cuyos resultados se quieren testear.
- `let`: Declara una variable con un determinado valor, y su definición tiene alcance en el bloque en donde se haya declarado.
Con `let` la variable se carga sólo cuando es usada por primera vez en el test y se mantiene en caché hasta que el ejemplo termina.
Existe una variante `let!` que se utiliza para definir la variable cuando el bloque es declarado.


### Herramientas esenciales

A continuación, se lista un conjunto de herramientas que se complementan perfectamente para
configurar el entorno de testing completo en cualquier aplicación Ruby on Rails:

- **RSpec en Ruby on Rails:** [RSpec](http://rspec.info/) es un conjunto de gemas que
implemetan un completo framework de testing para Ruby. Si nuestro campo de aplicación es
Ruby on Rails, entonces la gema [rspec-rails](https://github.com/rspec/rspec-rails)
es la herramienta que necesitamos utilizar, ya que nuclea varias dependencias para utilizar RSpec en nuestros proyectos RoR.

- **factory_bot:** [factory_bot](https://github.com/thoughtbot/factory_bot) es una gema que permite
definir *factories* o generadores dinámicos de estructuras de datos, útiles para alimentar nuestros tests. En el caso
específico de testing en aplicaciones RoR, la gema indicada es [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails).
Una buena práctica es generar un archivo de *factory* por cada modelo del sistema,
pudiendo tener múltiples factories asociadas jerárquicamente en el mismo archivo.
Cada una de estas factories son del mismo modelo, pero con alguna variación en uno o más de sus atributos.

- **Shoulda Matchers**: [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers) es otra gema desarrollada por los creadores de
`factory_bot`([Thoughtbot, Inc.](https://github.com/thoughtbot)), y sirve para reforzar tanto a RSpec como a Minitest con
operadores de *one-liner tests*, muy útiles para volver nuestros tests más legibles, compactos y menos propensos a errores.

### Otras herramientas útiles

A continuación, se lista un conjunto de herramientas opcionales que complementan
a las enumeradas anteriormente para cualquier aplicación Ruby on Rails:

- **Faker:** [Faker](https://github.com/stympy/faker) es una herramienta que permite definir valores aleatorios de datos
de diferentes tipos y categorías predefinidas, lo cual complementa perfectamente la labor de `factory_bot`.
Mientras que `factory_bot` se encarga de definir complejas y jerárquicas estructuras de datos, `Faker` juega un papel
importante en la generación de datos aleatorios para sus diferentes atributos.

- **should_not:** [should_not](https://github.com/should-not/should_not) es una gema que hace que nuestros tests fallen si los ejemplos (`it`) comienzan con `'should'` su descripción. Esto se debe a que RSpec alienta a que los ejemplos se escriban en tercera persona en tiempo presente.

### Puesta en marcha del proyecto

A modo de ejemplo, este repositorio contiene un proyecto Ruby on Rails con modelos, *factories* y tests sensillos.
Dicho proyecto está desarrollado utilizando Ruby `2.4.0` y Ruby on Rails `5.2.2`, y contiene todas las herramientas
citadas en este `README`, además de la correspondiente configuración de entorno.

A continuación, se listan los comandos para clonar proyecto, ponerlo en marcha y correr los tests exitosamente:

```
git clone https://github.com/lucashour/rspec-training.git
cd rspec
bundle install
rails db:create db:migrate
rspec
```

### Configurar entorno RSpec en proyecto Rails existente

A continuación, se detalla el proceso de configuración para agregar RSpec a un proyecto Ruby on Rails existente,
junto con todas las dependencias enunciadas en este `README`:

1. Agregar gemas necesarias al `Gemfile` en un `group` exclusivo de test:

  ```ruby
  group :test do
    gem 'factory_bot_rails'
    gem 'faker'
    gem 'rails-controller-testing'
    gem 'rspec-rails'
    gem 'shoulda-matchers', '~> 3.1.2'
    gem 'should_not'
  end
  ```

2. Instalar gemas:

  ```
  bundle install
  ```

3. Inicializar RSpec (crea directorio `spec/` y archivos de configuración `spec/rails_helper.rb` y `spec/spec_helper.rb`):

  ```
  rails generate rspec:install
  ```

4. Reemplazar contenido de `spec/rails_helper.rb` por el siguiente código:

  ```ruby
  require 'spec_helper'

  ENV['RAILS_ENV'] ||= 'test'

  require File.expand_path('../../config/environment', __FILE__)

  if Rails.env.production?
    abort('The Rails environment is running in production mode!')
  end

  require 'rspec/rails'
  require 'shoulda/matchers'

  ActiveRecord::Migration.maintain_test_schema!

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.infer_spec_type_from_file_location!
    config.filter_rails_from_backtrace!

    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end

    config.include FactoryBot::Syntax::Methods
  end

  RSpec::Matchers.define_negated_matcher :not_change, :change
  ```

  De esta forma, quedan configurados `Shoulda Matchers` y `factory_bot` para integrarse con RSpec.

5. Configurar generadores de Rails para utilizar RSpec como framework de testing, agregando el siguiente contenido al archivo `config/application.rb`:


  ```ruby
  config.generators do |generator|
    generator.test_framework :rspec
  end
  ```

### Estructura de carpetas sugerida

- `spec/`: Raíz de tests de aplicación.
  - `spec/factories/`: Carpeta de definición de `factories` de datos, para lo cual se utiliza `FactoryBot`.
  - `spec/controllers/`: Carpeta de definición de tests de controladores.
  - `spec/models/`: Carpeta de definición de tests de modelos.
  - `spec/services/`: Carpeta de definición de tests de servicios.
  - `spec/rails_helper.rb`: Archivo de configuración de tests de Rails.
  - `spec/spec_helper.rb`: Archivo de configuración de RSpec.

### Links de interés

- **RSpec**
  - [Web oficial de RSpec](http://rspec.info/)
  - [Guía de inicio de RSpec](http://www.betterspecs.org/)
  - [Guía de inicio de RSpec en Ruby on Rails](https://github.com/rspec/rspec-rails/blob/master/README.md)
  - [Documentación de RSpec en Ruby on Rails](https://relishapp.com/rspec/rspec-rails/docs)

- **factory_bot**
  - [Guía de inicio de factory_bot](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md)
  - [Cheatsheet de factory_bot](https://devhints.io/factory_bot)

- **Shoulda Matchers**
  - [Guía de inicio de Shoulda Matchers](https://matchers.shoulda.io/)
  - [Documentación de Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers/blob/master/README.md)
