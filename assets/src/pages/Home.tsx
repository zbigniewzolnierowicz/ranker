import { useDispatch, useSelector } from "react-redux"
import { AppDispatch, EPayloadActions, RootState } from "../store"

export const Home = () => {
    const logged_in = useSelector<RootState>(state => state.user.logged_in)
    const dispatch = useDispatch<AppDispatch>()
    return (
        <div>
            <h1>{JSON.stringify(logged_in)}</h1>
            <button onClick={() => dispatch({ type: EPayloadActions.LOG_USER_IN, payload: { id: 1, email: 'zbigniew.zolnierowicz@gmail.com' } })}>Toggle log in</button>
        </div>
    )
}