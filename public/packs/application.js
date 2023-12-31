var __create = Object.create;
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __getProtoOf = Object.getPrototypeOf;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __commonJS = (cb, mod) => function __require() {
  return mod || (0, cb[__getOwnPropNames(cb)[0]])((mod = { exports: {} }).exports, mod), mod.exports;
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toESM = (mod, isNodeMode, target) => (target = mod != null ? __create(__getProtoOf(mod)) : {}, __copyProps(
  // If the importer is in node compatibility mode or this is not an ESM
  // file that has been converted to a CommonJS file using a Babel-
  // compatible transform (i.e. "__esModule" has not been set), then set
  // "default" to the CommonJS "module.exports" for node compatibility.
  isNodeMode || !mod || !mod.__esModule ? __defProp(target, "default", { value: mod, enumerable: true }) : target,
  mod
));

// node_modules/controllers/lib/controllers.js
var require_controllers = __commonJS({
  "node_modules/controllers/lib/controllers.js"(exports, module2) {
    (function() {
      var Controllers, fs, path;
      var __slice = Array.prototype.slice;
      fs = require("fs");
      path = require("path");
      module2.exports = function(app, options) {
        var _ref, _ref2, _ref3, _ref4, _ref5;
        if (options == null)
          options = {};
        if ((_ref = options.strict) == null)
          options.strict = true;
        if ((_ref2 = options.overwriteRender) == null)
          options.overwriteRender = true;
        if ((_ref3 = options.log) == null)
          options.log = false;
        if ((_ref4 = options.root) == null) {
          options.root = app.set("controllers") || process.cwd() + "/controllers";
        }
        if ((_ref5 = options.sharedFolder) == null)
          options.sharedFolder = "shared";
        return new Controllers(app, options);
      };
      Controllers = function() {
        function Controllers2(app, options) {
          var originalRoute, self2;
          this.options = options;
          self2 = this;
          this._controllers = {};
          this.executeOnDirectory(this.options.root, function(file) {
            var controller, ext, reduced;
            ext = path.extname(file);
            if (ext === ".js" || ext === ".coffee") {
              reduced = file.replace(ext, "");
              controller = path.basename(reduced);
              self2._controllers[controller] = require(reduced);
              if (self2.options.log) {
                return console.log("Controller '" + controller + "' has been loaded");
              }
            }
          });
          originalRoute = app.routes._route;
          app.routes._route = function() {
            var c, callbacks, defaults, defkey, defvalue, holder, key, method, newCallbacks, newRoute, path2, result, _i, _j, _len, _len2, _ref;
            method = arguments[0], path2 = arguments[1], defaults = arguments[2], callbacks = 4 <= arguments.length ? __slice.call(arguments, 3) : [];
            if ("function" === typeof defaults) {
              callbacks.push(defaults);
              defaults = null;
            }
            if (callbacks.length === 0)
              callbacks.push(function(req, res) {
              });
            if (defaults == null)
              defaults = {};
            holder = {};
            for (_i = 0, _len = callbacks.length; _i < _len; _i++) {
              c = callbacks[_i];
              newCallbacks = self2.overwriteCallback(c, holder);
            }
            result = originalRoute.call(app.routes, method, path2, newCallbacks);
            holder.route = newRoute = result.routes[method][result.routes[method].length - 1];
            for (defkey in defaults) {
              defvalue = defaults[defkey];
              key = self2.getKeyInRoute(defkey, newRoute);
              if (key != null) {
                key["default"] = defvalue;
              } else {
                if (defkey === "controller" || defkey === "action") {
                  newRoute[defkey] = defvalue;
                }
              }
            }
            _ref = newRoute.keys;
            for (_j = 0, _len2 = _ref.length; _j < _len2; _j++) {
              key = _ref[_j];
              if (key.name === "controller" || key.name === "action") {
                newRoute[key.name] = "*";
              }
            }
            return result;
          };
          this.addHelpers(app);
        }
        Controllers2.prototype.addReqHelpers = function(req, res) {
          var self2;
          self2 = this;
          return req.executeController = function(controller, action, next) {
            var currentA, currentC, nextFunc;
            if (!(controller != null) || !(action != null)) {
              throw new Error("executeController needs the controller and action specified");
            }
            if (next != null) {
              currentC = req.controller;
              currentA = req.action;
              nextFunc = next;
              next = function() {
                req.controller = currentC;
                req.action = currentA;
                return nextFunc.apply(this, arguments);
              };
            }
            req.controller = controller;
            req.action = action;
            return self2._controllers[controller][action](req, res, next);
          };
        };
        Controllers2.prototype.addHelpers = function(app) {
          var self2;
          self2 = this;
          return app.dynamicHelpers({
            controller: function(req, res) {
              return req.controller;
            },
            action: function(req, res) {
              return req.action;
            },
            getUrl: function(req, res) {
              return function(controller, action, other, query) {
                var def, first, hasReplaced, i, key, regExp, replacement, result, route, value, _i, _len, _ref, _ref2, _ref3, _ref4;
                if (!(action != null) || "object" === typeof action) {
                  query = other;
                  other = action;
                  action = controller;
                  controller = null;
                }
                if (controller == null)
                  controller = req.controller;
                if (other == null)
                  other = {};
                other.controller = controller;
                other.action = action;
                if (query == null)
                  query = {};
                if (!(action != null) || !(controller != null)) {
                  throw new Error("getUrl needs at minimum an action defined, but also takes a controller");
                }
                _ref = app.routes.routes.get;
                for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                  route = _ref[_i];
                  if (self2.isMatchingPath(other, route)) {
                    hasReplaced = false;
                    result = route.path;
                    for (i = _ref2 = route.keys.length - 1; _ref2 <= 0 ? i <= 0 : i >= 0; _ref2 <= 0 ? i++ : i--) {
                      key = route.keys[i];
                      def = (_ref3 = key["default"]) != null ? _ref3 : "";
                      replacement = (_ref4 = other[key.name]) != null ? _ref4 : def;
                      if (hasReplaced && replacement === "") {
                        throw new Error("The optional parameter '" + key.name + "' is required for this getUrl call as an parameter further down the path has been specified");
                      } else {
                        if (!hasReplaced) {
                          if ((!key.optional || replacement !== def) && (hasReplaced = true)) {
                          } else {
                            replacement = "";
                          }
                        }
                      }
                      regExp = new RegExp(":" + key.name + "(\\?)?");
                      result = result.replace(regExp, replacement);
                    }
                    result = result.replace(/\/+/g, "/");
                    if (result !== "/")
                      result = result.replace(/\/+$/, "");
                    first = true;
                    for (key in query) {
                      value = query[key];
                      if (first) {
                        first = false;
                        result = result + "?" + key;
                        if (value != null && value !== "") {
                          result = result + "=" + value;
                        }
                      } else {
                        result = result + "&" + key;
                        if (value != null && value !== "") {
                          result = result + "=" + value;
                        }
                      }
                    }
                    return result;
                  }
                }
                throw new Error("Route could not be found that matches getUrl parameters, make sure to specify a valid controller, action and required parameters");
              };
            }
          });
        };
        Controllers2.prototype.getKeyInRoute = function(name, route) {
          var key, _i, _len, _ref;
          _ref = route.keys;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            key = _ref[_i];
            if (key.name === name)
              return key;
          }
          return null;
        };
        Controllers2.prototype.isMatchingPath = function(object, route) {
          var key, value, _i, _len, _ref;
          if (route.controller !== "*" && route.controller !== object.controller) {
            return false;
          }
          if (route.action !== "*" && route.action !== object.action)
            return false;
          for (key in object) {
            value = object[key];
            if (key !== "controller" && key !== "action") {
              if (!(this.getKeyInRoute(key, route) != null))
                return false;
            }
          }
          _ref = route.keys;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            key = _ref[_i];
            if (key.name !== "controller" && key.name !== "action") {
              if (!key.optional && !(object[key] != null))
                return false;
            }
          }
          return true;
        };
        Controllers2.prototype.overwriteCallback = function(callback, routeHolder) {
          var options, self2;
          self2 = this;
          options = this.options;
          return function(req, resp, next) {
            var action, controller, key, route, _i, _len, _ref, _ref2, _ref3;
            callback(req, resp, next);
            self2.addReqHelpers(req, resp);
            route = routeHolder.route;
            _ref = route.keys;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              key = _ref[_i];
              if (!(req.params[key.name] != null) && key["default"] != null) {
                req.params[key.name] = key["default"];
              }
            }
            req.controller = (_ref2 = req.params.controller) != null ? _ref2 : route.controller;
            req.action = (_ref3 = req.params.action) != null ? _ref3 : route.action;
            if (options.log) {
              console.log("Controller: " + req.controller);
              console.log("Action: " + req.action);
            }
            if (options.strict) {
              if (!(req.controller != null)) {
                throw new Error("Is in strict mode and no controller specified");
              }
              if (!(req.action != null)) {
                throw new Error("Is in strict mode and no action specified");
              }
            }
            if (req.controller != null && req.action != null) {
              if (options.overwriteRender)
                self2.overwriteRender(req, resp);
              controller = self2._controllers[req.controller];
              if (!(controller != null)) {
                if (options.log) {
                  console.log("Controller '" + req.controller + "' could not be found");
                }
                next("route");
                return;
              }
              action = controller[req.action];
              if (!(action != null)) {
                if (options.log) {
                  console.log("Action '" + req.action + "' could not be found on controller '" + req.controller + "' ");
                }
                next("route");
                return;
              }
              return action(req, resp, next);
            } else {
              if (options.log) {
                return console.log("Controller or action was not specified, no action was called");
              }
            }
          };
        };
        Controllers2.prototype.overwriteRender = function(req, resp) {
          var original, root, self2;
          self2 = this;
          original = resp.render;
          root = resp.app.set("views") || process.cwd() + "/views";
          return resp.render = function(view, opts, fn, parent, sub) {
            var finalPass, hasHints, reset, result, secondRender, secondResult;
            if ("object" === typeof view || "function" === typeof view) {
              sub = parent;
              parent = fn;
              fn = opts;
              opts = view;
              view = null;
            }
            if (view == null)
              view = req.action;
            hasHints = resp.app.enabled("hints");
            resp.app.disable("hints");
            result = null;
            secondResult = null;
            reset = function() {
              if (hasHints)
                return resp.app.enable("hints");
            };
            finalPass = function(err, err2, str) {
              reset();
              if (err != null)
                err = err + "\r\n\r\n" + err2;
              if (fn != null) {
                return fn(err, str);
              } else {
                if (err != null) {
                  return req.next(err);
                } else {
                  return resp.send(str);
                }
              }
            };
            secondRender = function(err, str) {
              if (err != null) {
                return secondResult = original.call(resp, self2.options.sharedFolder + "/" + view, opts, function(err2, str2) {
                  return finalPass(err2, err, str2);
                }, parent, sub);
              } else {
                reset();
                if (fn != null) {
                  return fn(err, str);
                } else {
                  return resp.send(str);
                }
              }
            };
            result = original.call(resp, req.controller + "/" + view, opts, secondRender, parent, sub);
            if (secondResult != null)
              result = secondResult;
            reset();
            return result;
          };
        };
        Controllers2.prototype.executeOnDirectory = function(dir, action) {
          return fs.readdirSync(dir).forEach(function(file) {
            var localpath, stat;
            localpath = dir + "/" + file;
            stat = fs.statSync(localpath);
            if (stat && stat.isDirectory()) {
              return self.executeOnDirectory(localpath, action);
            } else {
              return action(localpath);
            }
          });
        };
        return Controllers2;
      }();
    }).call(exports);
  }
});

// app/javascript/application.js
var import_turbo_rails = require("@hotwired/turbo-rails");
var import_controllers = __toESM(require_controllers());
