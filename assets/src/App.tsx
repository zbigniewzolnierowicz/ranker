import { FC, lazy, Suspense, useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { BrowserRouter as Router, Redirect, Route, Switch } from 'react-router-dom'
import Cookies from 'universal-cookie/es6'
import { Header } from './components/Header'
import { AppDispatch, RootState } from './store'
import { EUserPayloadActions, EUserPayloadlessActions } from './store/UserStore'
import { IUser } from './types/user'
import { client } from './utils/client'
import Home from './pages/Home'
import Users from './pages/Users'

const Me = lazy(() => import('./pages/Me'))
const Shop = lazy(() => import('./pages/Shop'))

export const App: FC = () => {
  const dispatch = useDispatch<AppDispatch>()
  const loggedIn = useSelector<RootState, boolean>(state => state.user.logged_in)
  useEffect(() => {
    const cookies = new Cookies()
    const user_id = cookies.get('user_id')
    async function fetchUserData(user_id: string) {
      const res = await client.get<IUser>(`/api/users/${user_id}`)
      dispatch({ type: EUserPayloadActions.LOG_USER_IN, payload: res.data })
    }
    if (user_id !== undefined) {
      fetchUserData(user_id)
    } else {
      dispatch({ type: EUserPayloadlessActions.LOG_USER_OUT })
    }
  }, [])

  return (
    <Router>
      <div>
        <Header />
        <Suspense fallback={<p>Loading...</p>}>
          <Switch>
            <Route path="/me">{loggedIn ? <Me /> : <Redirect to="/" />}</Route>
            <Route path="/shop">{loggedIn ? <Shop /> : <Redirect to="/" />}</Route>
            <Route exact path="/">
              {loggedIn ? <Users /> : <Home />}
            </Route>
          </Switch>
        </Suspense>
      </div>
    </Router>
  )
}
