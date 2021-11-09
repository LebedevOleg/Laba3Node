const Router = require('express')
const router = new Router()
const userController = require('../controller/user.controller')

router.post('/setUser', userController.setUser)
router.get('/getUser', userController.getUser)
router.get('/getOneUser', userController.getOneUser)
router.put('/updateUser', userController.updateUser)
router.delete('/deleteUser', userController.deleteUser)


module.exports = router