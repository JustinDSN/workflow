/*
 * Copyright 2019 Square Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import Workflow
import WorkflowUI
import WorkflowSplitScreenContainer


// MARK: Input and Output

struct DemoWorkflow: Workflow {

    typealias Output = Never

}


// MARK: State and Initialization

extension DemoWorkflow {

    struct State {
        var horizontal: Bool
    }

    func makeInitialState() -> State {
        return State(horizontal: true)
    }

    func workflowDidChange(from previousWorkflow: DemoWorkflow, state: inout State) {
    }

}

// MARK: Action

extension DemoWorkflow {
    enum Action: WorkflowAction {

        typealias WorkflowType = DemoWorkflow
        
        case viewTapped
        
        func apply(toState state: inout State) -> Never? {
            switch self {
            case .viewTapped:
                state.horizontal.toggle()
            }
            
            return nil
        }
    }
}


// MARK: Rendering

extension DemoWorkflow {

    typealias Rendering = SplitScreenContainerScreen

    func render(state: State, context: RenderContext<DemoWorkflow>) -> Rendering {
        let sink = context.makeSink(of: DemoWorkflow.Action.self)
        
        return SplitScreenContainerScreen(
            leftScreen: BaseScreen(
                title: "Left screen",
                backgroundColor: .red,
                viewTapped: { sink.send(.viewTapped )}
            ),
            rightScreen: BaseScreen(
                title: "Right screen",
                backgroundColor: .green,
                viewTapped: { sink.send(.viewTapped )}
            ),
            ratio: .third,
            separatorColor: .black,
            axis: state.horizontal ? .horizontal : .vertical
        )

    }

}
