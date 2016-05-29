using UnityEngine;
using System.Collections;

public class Boss : MonoBehaviour {

	public Material darkSky;
	public Light sun;

	private Animator anim;

	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	
	void OnTriggerEnter(Collider other) {
		
		if (other.tag == "Player") {
			
			BGM bgm = GameObject.Find ("BGM").GetComponent<BGM> ();
			bgm.Play3 ();

			RenderSettings.skybox = darkSky;
			anim = sun.GetComponent<Animator>();
			anim.SetBool("Dark", true);



		}
		
	}
}
