import Workflow


// MARK: Input and Output

struct MyWorkflow: Workflow {
    enum Output {
        case login(name: String)
    }
}


// MARK: State and Initialization

extension MyWorkflow {

    struct State {
        var name: String
    }

    func makeInitialState() -> MyWorkflow.State {
        return State(name: "")
    }

    func workflowDidChange(from previousWorkflow: MyWorkflow, state: inout State) {

    }
}


// MARK: Actions

extension MyWorkflow {

    enum Action: WorkflowAction {

        typealias WorkflowType = MyWorkflow

        case nameChanged(String)
        case login

        func apply(toState state: inout MyWorkflow.State) -> MyWorkflow.Output? {

            switch self {
            case .nameChanged(let updatedName):
                state.name = updatedName
                return nil

            case .login:
                return .login(name: state.name)
            }
        }
    }
}


// MARK: Rendering

extension MyWorkflow {
    typealias Rendering = MyScreen

    func render(state: MyWorkflow.State, context: RenderContext<MyWorkflow>) -> Rendering {
        let sink = context.makeSink(of: Action.self)
        return MyScreen(
            name: state.name,
            onNameChanged: { updatedName in
                sink.send(.nameChanged(updatedName))
            },
            onLoginTapped: {
                sink.send(.login)
            })
    }
}
