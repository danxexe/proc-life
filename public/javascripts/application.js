(function() {
  var Grid,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Grid = Grid = (function(_super) {

    __extends(Grid, _super);

    function Grid() {
      var cols, fill, pixel_size, rows, scaled_x, scaled_y, x, y, _i, _j;
      Grid.__super__.constructor.apply(this, arguments);
      pixel_size = 10;
      rows = 6;
      cols = 5;
      fill = "#999";
      for (y = _i = 1; _i <= 6; y = ++_i) {
        scaled_y = y * pixel_size;
        this.add(new fabric.Line([0, scaled_y, cols * pixel_size, scaled_y], {
          fill: fill
        }));
      }
      for (x = _j = 1; _j <= 5; x = ++_j) {
        scaled_x = x * pixel_size;
        this.add(new fabric.Line([scaled_x, 0, scaled_x, rows * pixel_size], {
          fill: fill
        }));
      }
    }

    return Grid;

  })(fabric.Group);

}).call(this);
(function() {
  var CreatureData;

  window.CreatureData = CreatureData = (function() {

    function CreatureData(w_or_data, h) {
      if (w_or_data == null) {
        w_or_data = 1;
      }
      if (h == null) {
        h = 1;
      }
      if (w_or_data instanceof Array) {
        this.rows = w_or_data;
        this.h = this.rows.length;
        this.w = this.rows[0].length;
      } else if (w_or_data instanceof CreatureData) {
        this.rows = w_or_data.rows;
        this.h = this.rows.length;
        this.w = this.rows[0].length;
      } else {
        this.w = w_or_data;
        this.h = h;
        this.rows = CreatureData.matrix(this.w, this.h);
      }
    }

    CreatureData.prototype.mutate = function(chance) {
      var new_data, new_p, new_row, p, row, x, y, _i, _j, _len, _len1, _ref;
      new_data = [];
      _ref = this.rows;
      for (y = _i = 0, _len = _ref.length; _i < _len; y = ++_i) {
        row = _ref[y];
        new_row = [];
        new_data.push(new_row);
        for (x = _j = 0, _len1 = row.length; _j < _len1; x = ++_j) {
          p = row[x];
          new_p = CreatureData.pixel(p, chance);
          new_row.push(new_p);
        }
      }
      return new CreatureData(new_data);
    };

    CreatureData.matrix = function(w, h) {
      var matrix, y, _i;
      matrix = [];
      for (y = _i = 0; 0 <= h ? _i < h : _i > h; y = 0 <= h ? ++_i : --_i) {
        matrix.push(this.matrix_row(w));
      }
      return matrix;
    };

    CreatureData.matrix_row = function(w) {
      var row, x, _i;
      row = [];
      for (x = _i = 0; 0 <= w ? _i < w : _i > w; x = 0 <= w ? ++_i : --_i) {
        row.push(this.pixel());
      }
      return row;
    };

    CreatureData.pixel = function(current, chance) {
      var flipped;
      if (current == null) {
        current = false;
      }
      if (chance == null) {
        chance = 0.5;
      }
      flipped = Math.floor(Math.random() * (1 / chance)) === 1;
      if (flipped) {
        return !current;
      } else {
        return current;
      }
    };

    return CreatureData;

  })();

}).call(this);
(function() {
  var CreatureFrame,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.CreatureFrame = CreatureFrame = (function(_super) {

    __extends(CreatureFrame, _super);

    function CreatureFrame(options) {
      var data_x, data_y, p, x, y, _i, _j, _k, _l, _len, _len1, _ref, _ref1, _ref2, _ref3, _results, _results1;
      if (options instanceof CreatureData) {
        this.data = options;
        options = null;
      } else {
        this.data = new CreatureData(3, 6);
      }
      CreatureFrame.__super__.constructor.apply(this, arguments);
      this.visible = true;
      this.pixel_size = 5;
      this.half_pixel_size = this.pixel_size / 2;
      this.set({
        width: (this.data.w + 2) * this.pixel_size
      });
      this.set({
        height: this.data.h * this.pixel_size
      });
      this.half_width = this.width / 2;
      this.half_height = this.height / 2;
      _ref1 = (function() {
        _results = [];
        for (var _j = 0, _ref = this.data.rows.length; 0 <= _ref ? _j < _ref : _j > _ref; 0 <= _ref ? _j++ : _j--){ _results.push(_j); }
        return _results;
      }).apply(this);
      for (y = _i = 0, _len = _ref1.length; _i < _len; y = ++_i) {
        data_y = _ref1[y];
        _ref3 = (function() {
          _results1 = [];
          for (var _l = 0, _ref2 = this.data.rows[data_y].length; 0 <= _ref2 ? _l < _ref2 : _l > _ref2; 0 <= _ref2 ? _l++ : _l--){ _results1.push(_l); }
          return _results1;
        }).apply(this).concat([1, 0]);
        for (x = _k = 0, _len1 = _ref3.length; _k < _len1; x = ++_k) {
          data_x = _ref3[x];
          p = this.data.rows[data_y][data_x];
          if (p) {
            this.add(new fabric.Rect({
              top: (y * this.pixel_size) - this.half_height + this.half_pixel_size,
              left: (x * this.pixel_size) - this.half_width + this.half_pixel_size,
              width: this.pixel_size,
              height: this.pixel_size
            }));
          }
        }
      }
    }

    CreatureFrame.prototype.mutate = function(chance) {
      return new CreatureFrame(this.data.mutate(chance));
    };

    CreatureFrame.prototype.toggleVisible = function() {
      return this.visible = !this.visible;
    };

    CreatureFrame.prototype.render = function(ctx, noTransform) {
      if (!this.visible) {
        return;
      }
      return CreatureFrame.__super__.render.call(this, ctx, noTransform);
    };

    return CreatureFrame;

  })(fabric.Group);

}).call(this);
(function() {
  var Creature,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Creature = Creature = (function(_super) {

    __extends(Creature, _super);

    function Creature(options) {
      var f, frame, _i, _j, _len, _len1, _ref, _ref1;
      this.frames = [];
      frame = null;
      if (options instanceof Creature) {
        frame = options.frames[0];
        _ref = options.frames;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          f = _ref[_i];
          this.frames.push(new CreatureFrame(f.data));
        }
        this.frames[1].set({
          visible: false
        });
        options = null;
      } else {
        frame = new CreatureFrame();
        this.frames.push(frame);
        this.frames.push(frame.mutate(0.2).set({
          visible: false
        }));
      }
      Creature.__super__.constructor.apply(this, arguments);
      this.set({
        width: frame.width
      });
      this.set({
        height: frame.height
      });
      this.time_since_toggle = 0;
      this.time_since_wander = 0;
      _ref1 = this.frames;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        frame = _ref1[_j];
        this.add(frame);
      }
      this.ai = new SteeredVehicle();
      this.ai.maxSpeed = 0.5 + Math.random() * 3;
      this.ai.maxForce = 1 + Math.random() * 0.3;
      this.ai.position = new Vector2D(world.width / 2, world.height / 2);
      this.ai.wanderAngle = 45;
      this.ai.bounds = {
        x: 0,
        y: 0,
        width: world.width,
        height: world.height
      };
      this.set({
        top: world.height / 2
      });
      this.set({
        left: world.width / 2
      });
      this.hasRotatingPoint = true;
      this.rotatingPointOffset;
      this.set({
        fill: this.randomColor()
      });
      this.set({
        opacity: 0.7
      });
      this.set({
        cornersize: 5
      });
    }

    Creature.prototype.update = function(dt, options) {
      var frame, _i, _len, _ref, _results;
      if (options == null) {
        options = {};
      }
      this.time_since_toggle += dt;
      this.time_since_wander += dt;
      if (options['ai'] !== false) {
        if (this.time_since_wander > 2) {
          this.time_since_wander = 0;
          this.ai.wander();
        }
        this.ai.update();
        this.set({
          left: this.ai.position.x
        });
        this.set({
          top: this.ai.position.y
        });
        this.rotate(this.ai.rotation + 90);
      }
      if (this.time_since_toggle > 400) {
        this.time_since_toggle = 0;
        _ref = this.frames;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          frame = _ref[_i];
          _results.push(frame.toggleVisible());
        }
        return _results;
      }
    };

    Creature.prototype.randomColor = function() {
      var color, letters, _i;
      letters = '0123456789ABCDEF'.split('');
      color = '#';
      for (_i = 0; _i < 6; _i++) {
        color += letters[Math.round(Math.random() * 15)];
      }
      return color;
    };

    return Creature;

  })(fabric.Group);

}).call(this);
(function() {

  $(function() {
    var animate, creature, creatures, grid, last_time, _i;
    $('#stage').attr({
      width: $(document).width()
    });
    $('#stage').attr({
      height: $(document).height()
    });
    window.world = new fabric.Canvas('stage');
    grid = new Grid();
    world.creatures = creatures = [];
    for (_i = 0; _i < 10; _i++) {
      creature = new Creature();
      creatures.push(creature);
      world.add(creature);
    }
    last_time = new Date().getTime();
    animate = function(time) {
      var dt, _j, _len;
      time || (time = last_time);
      dt = time - last_time;
      for (_j = 0, _len = creatures.length; _j < _len; _j++) {
        creature = creatures[_j];
        creature.update(dt);
      }
      if (typeof selected_creature !== "undefined" && selected_creature !== null) {
        selected_creature.update(dt, {
          ai: false
        });
      }
      last_time = time;
      world.renderAll();
      return requestAnimationFrame(animate);
    };
    animate();
    window.selected_creature = null;
    world.on('object:over', function(options) {
      world.remove(selected_creature);
      creature = options.target;
      window.selected_creature = new Creature(creature);
      selected_creature.top = selected_creature.height + 8;
      selected_creature.left = selected_creature.width + 8;
      selected_creature.scale(2);
      selected_creature.set({
        fill: creature.fill
      });
      return world.add(selected_creature);
    });
    return world.on('selection:created', function(options) {
      world.discardActiveGroup();
      creature = options.target.objects[0];
      return world.fire('object:selected', {
        target: creature
      });
    });
  });

}).call(this);
