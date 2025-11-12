import { application } from "./application"

const controllers = import.meta.glob("./*_controller.js", { eager: true })

for (const path in controllers) {
  const name = path
    .split("/")
    .pop()
    .replace("_controller.js", "")
  application.register(name, controllers[path].default)
}
