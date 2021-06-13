import { Link } from "@chakra-ui/react"
import { useDispatch, useSelector } from "react-redux"
import { AppDispatch, RootState } from "../store"
import { EUserPayloadActions } from "../store/UserStore"
import { IUser } from "../types/user"

export const Home = () => {
    const loggedIn = useSelector<RootState, boolean>(state => state.user.logged_in)
    const userData = useSelector<RootState, IUser>(state => state.user.user_data)
    return (
        <div>
            <Link href="/auth/logout">Log out</Link>
            {loggedIn ? (
                <div>
                    {JSON.stringify(userData)}
                </div>
            ) : ""}
        </div>
    )
}