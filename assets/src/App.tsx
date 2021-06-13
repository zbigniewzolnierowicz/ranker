import { useEffect } from "react";
import { useDispatch } from "react-redux";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom"
import Cookies from "universal-cookie/es6";
import { Header } from "./components/Header"
import { About } from "./pages/About";
import { Home } from "./pages/Home";
import { Users } from "./pages/Users";
import { AppDispatch } from "./store";
import { EUserPayloadActions, EUserPayloadlessActions } from "./store/UserStore";
import { IUser } from "./types/user";
import { client } from "./utils/client";

export const App = () => {
  const dispatch = useDispatch<AppDispatch>()
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
            <Switch>
              <Route path="/about">
                <About />
              </Route>
              <Route path="/users">
                <Users />
              </Route>
              <Route path="/">
                <Home />
              </Route>
            </Switch>
          </div>
        </Router>
      );
    
}