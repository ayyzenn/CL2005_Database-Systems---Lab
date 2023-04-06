const express = require('express')
const router = express.Router()
const { getGoals , setGoal, updateGoal, deletGoal } = require('../controllers/goalController')

router.route('/').get(getGoals).post(setGoal)

router.route('/:id').put(updateGoal).delete(deletGoal)

module.exports = router
